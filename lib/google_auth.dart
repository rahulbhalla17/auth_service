part of auth_service;

class GAuthentication {
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<UserInfoModel?> signInWithGoogle(
      {required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserInfoModel user = new UserInfoModel();
    User? userObj;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        final userData = userCredential.user;
        user.emailId = userData!.email!;
        user.name = userData.displayName!;
        user.tenantId = user.tenantId;
        //user.displayName = user.displayName;
        user.emailVerified = user.emailVerified;
        user.phoneNumber = user.phoneNumber;
        user.photoURL = user.photoURL;
        user.refreshToken = user.refreshToken;
        user.uid = user.uid;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          userObj = userCredential.user;
          print(userObj);
          print(userObj?.email);

          // user = UserInfoModel(
          //     userObj?.displayName,
          //     userObj?.email,
          //     userObj?.tenantId,
          //     userObj?.emailVerified,
          //     userObj?.phoneNumber,
          //     userObj?.photoURL,
          //     userObj?.refreshToken,
          //     userObj?.uid);
          user.emailId = userObj?.email!;
          user.name = userObj?.displayName!;
          user.tenantId = userObj?.tenantId;
          user.emailVerified = userObj?.emailVerified;
          user.phoneNumber = userObj?.phoneNumber;
          user.photoURL = userObj?.photoURL;
          user.refreshToken = userObj?.refreshToken;
          user.uid = userObj?.uid;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              GAuthentication.customSnackBar(
                content:
                    'The account already exists with a different credential',
              ),
            );
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              GAuthentication.customSnackBar(
                content:
                    'Error occurred while accessing credentials. Try again.',
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            GAuthentication.customSnackBar(
              content: 'Error occurred using Google Sign In. Try again.',
            ),
          );
        }
      }
    }

    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        GAuthentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }
}
