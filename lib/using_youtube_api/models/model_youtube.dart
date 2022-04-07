import 'dart:convert';

ChannelInfo channelInfoFromJson(String str) =>
    ChannelInfo.fromJson(jsonDecode(str));
String channelInfoToJson(ChannelInfo data) => jsonEncode(data.toJson());

class ChannelInfo {
  String? kind;
  String? etag;
  PageInfo? pageInfo;
  List<Item>? items;

  ChannelInfo({this.kind, this.etag, this.pageInfo, this.items});

  ChannelInfo.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    pageInfo = json['pageInfo'] != null
        ? new PageInfo.fromJson(json['pageInfo'])
        : null;
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalResults'] = this.totalResults;
    data['resultsPerPage'] = this.resultsPerPage;
    return data;
  }
}

class Item {
  String? kind;
  String? etag;
  String? id;
  Snippet? snippet;
  ContentDetails? contentDetails;
  Statistics? statistics;

  Item(
      {this.kind,
      this.etag,
      this.id,
      this.snippet,
      this.contentDetails,
      this.statistics});

  Item.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    snippet =
        json['snippet'] != null ? new Snippet.fromJson(json['snippet']) : null;
    contentDetails = json['contentDetails'] != null
        ? new ContentDetails.fromJson(json['contentDetails'])
        : null;
    statistics = json['statistics'] != null
        ? new Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    data['id'] = this.id;
    if (this.snippet != null) {
      data['snippet'] = this.snippet!.toJson();
    }
    if (this.contentDetails != null) {
      data['contentDetails'] = this.contentDetails!.toJson();
    }
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.toJson();
    }
    return data;
  }
}

class Snippet {
  String? title;
  String? description;
  String? customUrl;
  String? publishedAt;
  Thumbnails? thumbnails;
  Localized? localized;
  String? country;

  Snippet(
      {this.title,
      this.description,
      this.customUrl,
      this.publishedAt,
      this.thumbnails,
      this.localized,
      this.country});

  Snippet.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    customUrl = json['customUrl'];
    publishedAt = json['publishedAt'];
    thumbnails = json['thumbnails'] != null
        ? new Thumbnails.fromJson(json['thumbnails'])
        : null;
    localized = json['localized'] != null
        ? new Localized.fromJson(json['localized'])
        : null;
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['customUrl'] = this.customUrl;
    data['publishedAt'] = this.publishedAt;
    if (this.thumbnails != null) {
      data['thumbnails'] = this.thumbnails!.toJson();
    }
    if (this.localized != null) {
      data['localized'] = this.localized!.toJson();
    }
    data['country'] = this.country;
    return data;
  }
}

class Thumbnails {
  ThumpnailInfo? defualt;
  ThumpnailInfo? medium;
  ThumpnailInfo? high;

  Thumbnails({this.defualt, this.medium, this.high});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    defualt = json['ThumpnailInfo'] != null
        ? new ThumpnailInfo.fromJson(json['ThumpnailInfo'])
        : null;
    medium = json['medium'] != null
        ? new ThumpnailInfo.fromJson(json['medium'])
        : null;
    high =
        json['high'] != null ? new ThumpnailInfo.fromJson(json['high']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.defualt != null) {
      data['ThumpnailInfo'] = this.defualt!.toJson();
    }
    if (this.medium != null) {
      data['medium'] = this.medium!.toJson();
    }
    if (this.high != null) {
      data['high'] = this.high!.toJson();
    }
    return data;
  }
}

class ThumpnailInfo {
  String? url;
  int? width;
  int? height;

  ThumpnailInfo({this.url, this.width, this.height});

  ThumpnailInfo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Localized {
  String? title;
  String? description;

  Localized({this.title, this.description});

  Localized.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

class ContentDetails {
  RelatedPlaylists? relatedPlaylists;

  ContentDetails({this.relatedPlaylists});

  ContentDetails.fromJson(Map<String, dynamic> json) {
    relatedPlaylists = json['relatedPlaylists'] != null
        ? new RelatedPlaylists.fromJson(json['relatedPlaylists'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.relatedPlaylists != null) {
      data['relatedPlaylists'] = this.relatedPlaylists!.toJson();
    }
    return data;
  }
}

class RelatedPlaylists {
  String? likes;
  String? uploads;

  RelatedPlaylists({this.likes, this.uploads});

  RelatedPlaylists.fromJson(Map<String, dynamic> json) {
    likes = json['likes'];
    uploads = json['uploads'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likes'] = this.likes;
    data['uploads'] = this.uploads;
    return data;
  }
}

class Statistics {
  String? viewCount;
  String? subscriberCount;
  bool? hiddenSubscriberCount;
  String? videoCount;

  Statistics(
      {this.viewCount,
      this.subscriberCount,
      this.hiddenSubscriberCount,
      this.videoCount});

  Statistics.fromJson(Map<String, dynamic> json) {
    viewCount = json['viewCount'];
    subscriberCount = json['subscriberCount'];
    hiddenSubscriberCount = json['hiddenSubscriberCount'];
    videoCount = json['videoCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['viewCount'] = this.viewCount;
    data['subscriberCount'] = this.subscriberCount;
    data['hiddenSubscriberCount'] = this.hiddenSubscriberCount;
    data['videoCount'] = this.videoCount;
    return data;
  }
}
