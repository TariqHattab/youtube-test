import 'package:google_sign_in/google_sign_in.dart';

class UsingGoogle {
  static signin() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          // 'email',

          'https://www.googleapis.com/auth/youtube.force-ssl',
        ],
      );
      GoogleSignInAccount? res;
      try {
        res = await _googleSignIn.signIn();
        var authRes = await res?.authentication;
        print(res);
        print(authRes);
        print(authRes?.accessToken);
        print(authRes?.idToken);
      } catch (error) {
        print(error);
      }
      return res;
    } catch (e) {
      print(e);
    }
  }
}
