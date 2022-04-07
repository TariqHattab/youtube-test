import 'dart:convert';

VideosList videosListFromJson(String str) =>
    VideosList.fromJson(jsonDecode(str));
String videosListToJson(VideosList data) => jsonEncode(data.toJson());

class VideosList {
  String? kind;
  String? etag;
  String? nextPageToken;
  List<VideoItem>? videos;
  PageInfo? pageInfo;

  VideosList(
      {this.kind, this.etag, this.nextPageToken, this.videos, this.pageInfo});

  VideosList.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    nextPageToken = json['nextPageToken'];
    if (json['items'] != null) {
      videos = <VideoItem>[];
      json['items'].forEach((v) {
        videos!.add(VideoItem.fromJson(v));
      });
    }
    pageInfo =
        json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    data['nextPageToken'] = this.nextPageToken;
    if (this.videos != null) {
      data['items'] = this.videos!.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo!.toJson();
    }
    return data;
  }
}

class VideoItem {
  String? kind;
  String? etag;
  String? id;
  Video? video;

  VideoItem({this.kind, this.etag, this.id, this.video});

  VideoItem.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    video = json['snippet'] != null ? Video.fromJson(json['snippet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    data['id'] = this.id;
    if (this.video != null) {
      data['snippet'] = this.video!.toJson();
    }
    return data;
  }
}

class Video {
  String? publishedAt;
  String? channelId;
  String? title;
  String? description;
  Thumbnails? thumbnails;
  String? channelTitle;
  String? playlistId;
  int? position;
  ResourceId? resourceId;
  String? videoOwnerChannelTitle;
  String? videoOwnerChannelId;

  Video(
      {this.publishedAt,
      this.channelId,
      this.title,
      this.description,
      this.thumbnails,
      this.channelTitle,
      this.playlistId,
      this.position,
      this.resourceId,
      this.videoOwnerChannelTitle,
      this.videoOwnerChannelId});

  Video.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    thumbnails = json['thumbnails'] != null
        ? Thumbnails.fromJson(json['thumbnails'])
        : null;
    channelTitle = json['channelTitle'];
    playlistId = json['playlistId'];
    position = json['position'];
    resourceId = json['resourceId'] != null
        ? ResourceId.fromJson(json['resourceId'])
        : null;
    videoOwnerChannelTitle = json['videoOwnerChannelTitle'];
    videoOwnerChannelId = json['videoOwnerChannelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['publishedAt'] = this.publishedAt;
    data['channelId'] = this.channelId;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.thumbnails != null) {
      data['thumbnails'] = this.thumbnails!.toJson();
    }
    data['channelTitle'] = this.channelTitle;
    data['playlistId'] = this.playlistId;
    data['position'] = this.position;
    if (this.resourceId != null) {
      data['resourceId'] = this.resourceId!.toJson();
    }
    data['videoOwnerChannelTitle'] = this.videoOwnerChannelTitle;
    data['videoOwnerChannelId'] = this.videoOwnerChannelId;
    return data;
  }
}

class Thumbnails {
  ThumbInfo? defult;
  ThumbInfo? medium;
  ThumbInfo? high;
  ThumbInfo? standard;
  ThumbInfo? maxres;

  Thumbnails({this.defult, this.medium, this.high, this.standard, this.maxres});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    defult =
        json['default'] != null ? ThumbInfo.fromJson(json['default']) : null;
    medium = json['medium'] != null ? ThumbInfo.fromJson(json['medium']) : null;
    high = json['high'] != null ? ThumbInfo.fromJson(json['high']) : null;
    standard =
        json['standard'] != null ? ThumbInfo.fromJson(json['standard']) : null;
    maxres = json['maxres'] != null ? ThumbInfo.fromJson(json['maxres']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.defult != null) {
      data['default'] = this.defult!.toJson();
    }
    if (this.medium != null) {
      data['medium'] = this.medium!.toJson();
    }
    if (this.high != null) {
      data['high'] = this.high!.toJson();
    }
    if (this.standard != null) {
      data['standard'] = this.standard!.toJson();
    }
    if (this.maxres != null) {
      data['maxres'] = this.maxres!.toJson();
    }
    return data;
  }
}

class ThumbInfo {
  String? url;
  int? width;
  int? height;

  ThumbInfo({this.url, this.width, this.height});

  ThumbInfo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class ResourceId {
  String? kind;
  String? videoId;

  ResourceId({this.kind, this.videoId});

  ResourceId.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    videoId = json['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['videoId'] = this.videoId;
    return data;
  }
}

class PageInfo {
  int? totalResults;
  int? resultsPerPage;

  PageInfo({this.totalResults, this.resultsPerPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    resultsPerPage = json['resultsPerPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['totalResults'] = this.totalResults;
    data['resultsPerPage'] = this.resultsPerPage;
    return data;
  }
}
