part of auth_service;

class FAuthentication {
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<UserInfoModel?> fbLoginMethod(
      {required BuildContext context}) async {
    UserInfoModel user = new UserInfoModel();
    try {
      final LoginResult result = await FacebookAuth.instance
          .login(); // by default we request the email and the public profile
      if (result.status == LoginStatus.success) {
        print("logged in");
        final userData = await FacebookAuth.i.getUserData();

        user.emailId = userData['email'];
        user.name = userData['name'];
        // user = UserInfoModel(
        //   user?.displayName,
        //   user?.emailId,
        // );

        //user?.name = userData['name'];
        //user?.emailId = userData['email'];
      } else if (result.status == LoginStatus.failed) {
        ScaffoldMessenger.of(context).showSnackBar(
          FAuthentication.customSnackBar(
            content: 'Facebook log in failed',
          ),
        );
        //context.showErrorSnackbar(message: "Facebook log in failed");
      }
    } catch (e) {
      print("exception : " + e.toString());
    }
    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    //final GoogleSignIn googleSignIn = GoogleSignIn();
    await FacebookAuth.instance.logOut();

    // try {
    //   if (!kIsWeb) {
    //     await googleSignIn.signOut();
    //   }
    //   await FirebaseAuth.instance.signOut();
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     GAuthentication.customSnackBar(
    //       content: 'Error signing out. Try again.',
    //     ),
    //   );
    // }
  }
}
