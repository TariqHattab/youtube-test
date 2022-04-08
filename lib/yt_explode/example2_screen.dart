import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadExample2 extends StatefulWidget {
  DownloadExample2({
    Key? key,
  }) : super(key: key);

  @override
  DownloadExample2State createState() => DownloadExample2State();
}

class DownloadExample2State extends State<DownloadExample2> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('download example 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Insert the video id or url',
            ),
            TextField(controller: textController),
            RaisedButton(
                child: const Text('Download'),
                onPressed: () async {
                  // Here you should validate the given input or else an error
                  // will be thrown.
                  var yt = YoutubeExplode();
                  var id = VideoId(textController.text.trim());
                  print('---call 1');
                  var video = await yt.videos.get(id);
                  print('---call 1 finished video = $video ');

                  // Display info about this video.
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                            'Title: ${video.title}, Duration: ${video.duration}'),
                      );
                    },
                  );

                  // Request permission to write in an external directory.
                  // (In this case downloads)
                  print('---call 2 Permission');
                  await Permission.storage.request();
                  print('---call 2 finished  Permission ');
                  // Get the streams manifest and the audio track.
                  var manifest = await yt.videos.streamsClient.getManifest(id);
                  var audio = manifest.audioOnly.last;

                  Directory appDocDir =
                      await getApplicationDocumentsDirectory();
                  String appDocPath = appDocDir.path;
                  var file = File('$appDocPath/${video.id}');
                  var fileStream = file.openWrite();

                  // Pipe all the content of the stream into our file.
                  await yt.videos.streamsClient.get(audio).pipe(fileStream);
                  /*
                  If you want to show a % of download, you should listen
                  to the stream instead of using `pipe` and compare
                  the current downloaded streams to the totalBytes,
                  see an example ii example/video_download.dart
                   */

                  // Close the file.
                  await fileStream.flush();
                  await fileStream.close();

                  // Show that the file was downloaded.
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                            'Download completed and saved to: ${appDocPath}'),
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
