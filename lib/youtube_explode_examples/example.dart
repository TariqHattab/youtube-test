import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// ignore_for_file: avoid_print
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DummyYoutubeExplodePage extends StatefulWidget {
  const DummyYoutubeExplodePage({Key? key}) : super(key: key);

  @override
  State<DummyYoutubeExplodePage> createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyYoutubeExplodePage> {
  String? streamInfoData;
  bool isloading = false;
  double progress = 0;
  File? downloadedFile;

  Future<void> getStreamInfo() async {
    setState(() {
      isloading = true;
    });
    var url =
        'https://www.youtube.com/watch?v=w7fPVD3urV4&ab_channel=NoahKagan';
    var videoId = 'w7fPVD3urV4';
    var yt = YoutubeExplode();
    print('case 1');
    StreamManifest? streamInfo;
    try {
      streamInfo = await yt.videos.streamsClient.getManifest(url);
    } catch (e) {
      print('getManifest failed');
      print('case 1 finished failer');
      print('case 1 error is $e');
      return;
    }
    print('case 1 finished');

    var audio = streamInfo.muxed.bestQuality;
    var audioStream = yt.videos.streamsClient.get(audio);

    print('case 2');
    Directory appDocDir = await getApplicationDocumentsDirectory();
    print('case 2 finished');
    String appDocPath = appDocDir.path;
    var file = File('$appDocPath/$videoId');
    print(file);
    // var fileStream = file.openWrite();

    // Pipe all the content of the stream into our file.
    // await yt.videos.streamsClient.get(audio).pipe(fileStream);
    //delete file if exists
    // if (file.existsSync()) {
    //   file.deleteSync();
    // }
    var output = file.openWrite(mode: FileMode.writeOnlyAppend);
    var size = audio.size.totalBytes;
    var count = 0;
    print(output);
    await for (final data in audioStream) {
      // Keep track of the current downloaded data.
      count += data.length;
      print(count);
      // Calculate the current progress.
      double val = ((count / size));
      print(val);
      var msg = 'title video Downloaded to $appDocPath/$videoId';
      if (val == 1) {
        // for (val; val == 1.0; val++) {
        if (mounted)
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(msg)));
        print(file);
      }
      if (mounted) {
        setState(() => progress = val);
      }

      // Write to file.
      output.add(data);
    }

    // // Close the file.
    // await fileStream.flush();
    // await fileStream.close();

    print(streamInfo);
    if (mounted) {
      setState(() {
        downloadedFile = File('$appDocPath/$videoId');
        streamInfoData = streamInfo.toString();
        isloading = false;
      });
    }
    // Close the YoutubeExplode's http client.
    yt.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('example.dart'),
        centerTitle: true,
      ),
      body: isloading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.blueAccent,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              ),
            )
          : Center(child: Text(streamInfoData ?? 'no date yet')),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            getStreamInfo();
          },
          child: Icon(Icons.get_app)),
    );
  }
}
