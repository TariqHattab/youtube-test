import 'package:yt/yt.dart';

class YTPackage {
  static void uplaodVid() async {
    final yt = Yt.withOAuth(OAuthCredentials.fromYaml('youtube.yaml'));

    final videos = await yt.videos;

    // final body = <String, dynamic>{
    //   'snippet': {
    //     'title': 'TEST title',
    //     'description': 'Test Description',
    //     'tags': ['tag1', 'tag2'],
    //     'categoryId': "22"
    //   },
    //   'status': {
    //     'privacyStatus': 'private',
    //     "embeddable": true,
    //     "license": "youtube"
    //   }
    // };
    String urlToGenerateCode =
        '''https://accounts.google.com/o/oauth2/auth?client_id=893374381766-daqadd26ebeneegbgguodlg64m0bsf1r.apps.googleusercontent.com&redirect_uri=http://localhost:1/&scope=https://www.googleapis.com/auth/youtube&response_type=code''';
    final videoItem = await videos.list(
      part: 'snippet,status,contentDetails',
      id: 'MOfeXHO2Q30',
    );

// print(videoItem);
  }
}
