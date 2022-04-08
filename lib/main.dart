import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_test/using_youtube_api/screens/youtube_api.dart';

import 'package:youtube_test/youtube_player_flutter/youtube_player_flutter_main.dart';
import 'package:youtube_test/yt_explode/example.dart';
import 'package:youtube_test/yt_explode/example2_screen.dart';

import 'download_video/download_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Pages(),
    );
  }
}

class Pages extends StatelessWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        HomeScreen(),
        const DummyYoutubeExplodePage(),
        const DownloadScreen(),
        DownloadExample2(),
        YoutubePlayerDemoApp(),
      ],
    );
  }
}
