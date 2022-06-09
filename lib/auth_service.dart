library auth_service;

import 'package:auth_service/models/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

part 'facebook_auth.dart';
part 'google_auth.dart';

class AuthService {
  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<UserInfoModel?> signIn(
      {required BuildContext context, required String type}) async {
    if (type == 'facebook') {
      final userData = await FAuthentication.fbLoginMethod(context: context);
      return userData;
    } else if (type == 'google') {
      final user = await GAuthentication.signInWithGoogle(context: context);
      return user;
    } else if (type == 'instagram') {
    } else {}
  }

  static Future<UserInfoModel?> signOut(
      {required String type, required String ID}) async {
    if (type == 'facebook') {
    } else if (type == 'google') {
    } else if (type == 'instagram') {
    } else {}
  }
}
