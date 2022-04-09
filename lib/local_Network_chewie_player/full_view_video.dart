import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';

//* Video from online player

class FullViewVideo extends StatefulWidget {
  final String? videoUrl;
  final File? file;

  const FullViewVideo({
    Key? key,
    this.videoUrl,
    this.file,
  }) : super(key: key);

  @override
  _FullViewVideoState createState() => _FullViewVideoState();
}

class _FullViewVideoState extends State<FullViewVideo> {
  @override
  void initState() {
    playVideo(widget.videoUrl, widget.file);
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
    _videoPlayerController?.dispose();
    _chewieController?.pause();

    print("Video disposed");
  }

  @override
  Widget build(BuildContext context) {
    bool status = MediaQuery.of(context).orientation.index == 1;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            _chewieController != null &&
                    _chewieController!.videoPlayerController.value.isInitialized
                ? Container(
                    child: Chewie(
                      controller: _chewieController!,
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
            Positioned(
                top: 6,
                left: 5,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: status ? 55 : 50,
                    height: status ? 45 : 30,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white70,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.22),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  ChewieController? _chewieController;
  VideoPlayerController? _videoPlayerController;

  Future<void> playVideo(String? videoPath, File? file) async {
    if (file != null) {
      _videoPlayerController = VideoPlayerController.file(file);
    } else if (videoPath != null) {
      _videoPlayerController = VideoPlayerController.network(videoPath);
    } else {
      return;
    }

    await _videoPlayerController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: true,

      // Try playing around with some of these other options:

      showControls: true,
      allowFullScreen: false,

      materialProgressColors: ChewieProgressColors(
        // playedColor: primaryColor,
        // handleColor: primaryColor,
        backgroundColor: Colors.black,
        bufferedColor: Colors.grey[300]!,
      ),
      placeholder: const CircularProgressIndicator.adaptive(),
      autoInitialize: true,
    );
    setState(() {});
  }
}

//* Video from assets player

class LocalFullViewVideo extends StatefulWidget {
  final String videoLocalPath;

  const LocalFullViewVideo({Key? key, required this.videoLocalPath})
      : super(key: key);

  @override
  _LocalFullViewVideoState createState() => _LocalFullViewVideoState();
}

class _LocalFullViewVideoState extends State<LocalFullViewVideo> {
  @override
  void initState() {
    playVideo(widget.videoLocalPath);
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
    _videoPlayerController?.dispose();
    _chewieController?.pause();

    print("Video disposed");
  }

  @override
  Widget build(BuildContext context) {
    bool status = MediaQuery.of(context).orientation.index == 1;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
            onHorizontalDragUpdate: (details) => Navigator.pop(context),
            child: Stack(
              children: [
                _chewieController != null &&
                        _chewieController!
                            .videoPlayerController.value.isInitialized
                    ? Container(
                        child: Chewie(
                          controller: _chewieController!,
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                Positioned(
                    top: 6,
                    left: 5,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: status ? 55 : 50,
                        height: status ? 45 : 30,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white70,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.22),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )),
              ],
            )),
      ),
    );
  }

  ChewieController? _chewieController;
  VideoPlayerController? _videoPlayerController;

  Future<void> playVideo(String videoPath) async {
    _videoPlayerController = VideoPlayerController.asset(widget.videoLocalPath);

    await _videoPlayerController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      showControls: true,
      allowFullScreen: false,

      materialProgressColors: ChewieProgressColors(
        // playedColor: primaryColor,
        // handleColor: primaryColor,
        backgroundColor: Colors.black,
        bufferedColor: Colors.grey[300]!,
      ),
      placeholder: Container(
        width: 50,
        height: 50,
        color: Colors.transparent,
      ),
      autoInitialize: true,
    );
    setState(() {});
  }
}
