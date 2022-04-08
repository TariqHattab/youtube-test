import 'dart:io';

import 'package:http/http.dart';
import 'package:youtube_test/using_youtube_api/models/videos_list.dart';
import 'package:youtube_test/using_youtube_api/utils/constants.dart';
import 'package:youtube_test/using_youtube_api/models/model_youtube.dart';
import 'package:http/http.dart' as http;

class Services {
  static const CHANNEL_ID = 'UCU8Mj6LLoNBXqqeoOD64tFg';
  static const _baseUrl = 'www.googleapis.com';
  static Future<ChannelInfo> getChannelInfo({String? channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': channelId ?? CHANNEL_ID,
      'key': API_KEY,
      // 'access_token': access_token,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    http.Response response = await http.get(uri, headers: headers);
    // print(response.body);
    ChannelInfo channelInfo = channelInfoFromJson(response.body);
    return channelInfo;
  }

  static Future<Response> getVideoInfo({String? channelId}) async {
    // to get data first need
    //access token from google sign in
    // you can look for a way to refresh later
    //
    Map<String, String> parameters = {
      'part':
          'snippet,contentDetails,statistics', //fileDetails,processingDetails,recordingDetails
      'id': '01xazH8rmoo', //'MOfeXHO2Q30', //channelId ?? CHANNEL_ID,
      'key': API_KEY,
      // 'access_token': access_token,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/videos',
      parameters,
    );
    http.Response response = await http.get(uri, headers: headers);
    // print(response.body);
    // ChannelInfo channelInfo = channelInfoFromJson(response.body);
    return response;
  }

  static Future<VideosList> getVideosList(
      {required String playListId, required String pageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playListId,
      'maxResults': '8',
      'pageToken': pageToken,
      'key': API_KEY,
      // 'access_token': access_token,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    // print(response.body);
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }
}
