import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:youtube_test/using_youtube_api/models/model_youtube.dart';
import 'package:youtube_test/using_youtube_api/models/videos_list.dart';
import 'package:youtube_test/using_youtube_api/screens/video_player_screen.dart';
import 'package:youtube_test/using_youtube_api/utils/service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  late ChannelInfo _channelInfo;
  late VideosList _videosList;
  late Item _item;
  late bool _loading;
  String? _playListId;
  late String _nextPageToken;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _nextPageToken = '';
    _scrollController = ScrollController();
    _videosList = VideosList();
    _videosList.videos = [];
    _getChannelInfo();
  }

  _getChannelInfo() async {
    _channelInfo = await Services.getChannelInfo();
    _item = _channelInfo.items![0];
    _playListId = _item.contentDetails?.relatedPlaylists?.uploads;
    print('_playListId $_playListId');
    await _loadVideos();
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  _loadVideos() async {
    VideosList tempVideosList = await Services.getVideosList(
      playListId: _playListId!,
      pageToken: _nextPageToken,
    );
    _nextPageToken = tempVideosList.nextPageToken ?? '';
    _videosList.videos?.addAll(tempVideosList.videos ?? []);
    print('videos: ${_videosList.videos?.length}');
    print('_nextPageToken $_nextPageToken');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'Using YouTube Api '),
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () async {
      //         Response response = await Services.getVideoInfo();
      //         print(response.body);
      //       },
      //       child: const Icon(Icons.send),
      //     ),
      //     const SizedBox(
      //       width: 10,
      //     ),
      //     FloatingActionButton(
      //       onPressed: () async {
      //         GoogleSignInAccount? response = await UsingGoogle.signin();
      //         print(response);
      //       },
      //       child: const Icon(Icons.ad_units),
      //     ),
      //     const SizedBox(
      //       width: 10,
      //     ),
      //     FloatingActionButton(
      //       onPressed: () async {
      //         _getChannelInfo();
      //         // print(response);
      //       },
      //       child: const Icon(Icons.change_circle_outlined),
      //     ),
      //   ],
      // ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildInfoView(),
            Expanded(
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (ScrollNotification notification) {
                  if ((_videosList.videos?.length ?? 0) >=
                      int.parse(_item.statistics?.videoCount ?? '0')) {
                    return true;
                  }
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    _loadVideos();
                  }
                  return true;
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _videosList.videos?.length,
                  itemBuilder: (context, index) {
                    VideoItem videoItem = _videosList.videos![index];
                    return InkWell(
                      onTap: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return VideoPlayerScreen(
                            videoItem: videoItem,
                          );
                        }));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  videoItem.video?.thumbnails?.defult?.url ??
                                      '',
                            ),
                            const SizedBox(width: 20),
                            Flexible(
                                child: Text(videoItem.video?.title ??
                                    'video was null so no title')),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildInfoView() {
    return _loading
        ? const CircularProgressIndicator()
        : Container(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        _item.snippet?.thumbnails?.medium?.url ?? '',
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        _item.snippet?.title ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(_item.statistics?.videoCount ?? 'statistics was null'),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          );
  }
}
