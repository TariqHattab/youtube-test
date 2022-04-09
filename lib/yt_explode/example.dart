import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// ignore_for_file: avoid_print
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../local_Network_chewie_player/full_view_video.dart';

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

  // @override
  // initState() {
  //   super.initState();
  //   downloadedFile =
  //       File('/data/user/0/com.example.youtube_test/app_flutter/01xazH8rmoo-2');
  // }

  Future<void> getStreamInfo() async {
    setState(() {
      isloading = true;
    });
    var url =
        'https://www.youtube.com/watch?v=LXb3EKWsInQ&ab_channel=Jacob%2BKatieSchwarz';
    var videoId = '01xazH8rmoo';
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
    // for (var s in streamInfo.muxed) {
    //   log(s.toJson()['tag'].toString());
    //   log(s.toJson()['url'].toString());
    //   log(s.toJson()['videoResolution'].toString());
    //   log(s.toJson()['videoQuality'].toString());
    //   log(s.toJson()['size'].toString()); //315//337
    // }
    var audio = streamInfo.muxed[2];
    // var audio = streamInfo.videoOnly.firstWhere((e) => e.tag == 315);
    var audioStream = yt.videos.streamsClient.get(audio);
    // log(audioStream.toString());
    print(audioStream);
    print('case 2');
    Directory appDocDir = await getApplicationDocumentsDirectory();
    print('case 2 finished');
    String appDocPath = appDocDir.path;
    var file = File('$appDocPath/$videoId');
    print(file);

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
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(msg)));
        }
        print(file);
      }
      if (mounted) {
        setState(() => progress = val);
      }

      // Write to file.
      output.add(data);
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => FullViewVideo(
                  file: file,
                )));
    // // Close the file.
    // await fileStream.flush();
    // await fileStream.close();

    print(streamInfo);
    if (mounted) {
      setState(() {
        downloadedFile = File('$appDocPath/$videoId');
        downloadedFile?.stat().then((value) {
          if (mounted) {
            print(
                "-----------------------------------------------------------------------------------------------------------");
            print(value.size.toString());
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value.size.toString())));
          }
        });

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
        title: const Text('yt_explode/example.dart'),
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
          : Center(child: Text(streamInfoData ?? 'click to download')),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
              onPressed: () {
                // getStreamInfo();
              },
              child: const Icon(Icons.get_app)),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => FullViewVideo(
                              file: downloadedFile,
                            )));
              },
              child: const Icon(Icons.video_file_outlined)),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
