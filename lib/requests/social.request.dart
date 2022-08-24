import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_strings.dart';

class SocialRequest{
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Map> handleSignInGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user!;

      assert(!user.isAnonymous);

      final User currentUser = _auth.currentUser!;
      assert(user.uid == currentUser.uid);

      signOutGoogle();

      String firstName = '';
      String lastName = '';

      if (currentUser.displayName.validate().split(' ').length >= 1) firstName = currentUser.displayName.splitBefore(' ');
      if (currentUser.displayName.validate().split(' ').length >= 2) lastName = currentUser.displayName.splitAfter(' ');

      setValue(AppStrings.profileImg, currentUser.photoURL!);

      Map req = {
        "email": currentUser.email,
        "firstName": firstName,
        "lastName": lastName,
        "displayName": currentUser.displayName,
        "photoURL": currentUser.photoURL,
        "accessToken": googleSignInAuthentication.accessToken,
        "loginType": 'google',
      };
      return req;
    } else {
      throw errorSomethingWentWrong;
    }
  }

  Future<Map> handleSignInFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login(
      // permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
    );

    if(result.status == LoginStatus.success){
      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      final UserCredential authResult = await _auth.signInWithCredential(credential);

      final User user = authResult.user!;

      assert(!user.isAnonymous);

      final User currentUser = _auth.currentUser!;
      assert(user.uid == currentUser.uid);

      signOutFacebook();

      String firstName = '';
      String lastName = '';

      if (currentUser.displayName.validate().split(' ').length >= 1) firstName = currentUser.displayName.splitBefore(' ');
      if (currentUser.displayName.validate().split(' ').length >= 2) lastName = currentUser.displayName.splitAfter(' ');

      setValue(AppStrings.profileImg, "${currentUser.photoURL!}?type=large");

      Map req = {
        "email": currentUser.email,
        "firstName": firstName,
        "lastName": lastName,
        "displayName": currentUser.displayName,
        "photoURL": currentUser.photoURL,
        "accessToken": user.refreshToken,
        "loginType": 'facebook',
      };

      return req;
    }else{
      throw errorSomethingWentWrong;
    }
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }

  Future<void> signOutFacebook() async {
    await FacebookAuth.i.logOut();
  }

}