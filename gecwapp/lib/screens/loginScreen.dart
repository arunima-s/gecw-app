import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/screens/homeScreen.dart';
import 'package:gecwapp/screens/scholarshipScreen.dart';
import 'package:gecwapp/screens/semesterScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class LoginScreen extends StatelessWidget {
  // const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login"),
              // Login Button
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                    style: ButtonStyle(
                        // padding: MaterialStateProperty.a,
                        foregroundColor: MaterialStateProperty.all<Color>(
                            AppColors.primaryColor),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: AppColors.primaryColor)))),
                    onPressed: null,
                    child: Row(
                      children: [
                        Image.asset('assets/images/google24.png'),
                        Text("Login using Google")
                      ],
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                    style: ButtonStyle(
                        // padding: MaterialStateProperty.a,
                        foregroundColor: MaterialStateProperty.all<Color>(
                            AppColors.primaryColor),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: AppColors.primaryColor)))),
                    onPressed: () {
                      signInWithGoogle(context);
                      // .whenComplete(() {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => HomeScreen()));
                      // });
                    },
                    child: Row(
                      children: [
                        Image.asset('assets/images/facebook24.png'),
                        Text("Login using Facebook")
                      ],
                    )),
              )
            ]),
      ),
    );
  }

  // Future<void> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   print(await FirebaseAuth.instance.signInWithCredential(credential));

  //   // Once signed in, return the UserCredential
  //   // return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final authResult = await _auth.signInWithCredential(credential);
    final User? user = authResult.user;
    assert(!user!.isAnonymous);
    assert(await user?.getIdToken() != null);
    final User currentUser = await _auth.currentUser!;
    assert(user?.uid == currentUser.uid);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);

    // return 'signInWithGoogle succeeded: $user';
  }
}
