import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/userModel.dart';
import 'package:gecwapp/Utilities/popup_messages.dart';
import 'package:gecwapp/screens/homeScreen.dart';
import 'package:gecwapp/screens/scholarshipScreen.dart';
import 'package:gecwapp/screens/semesterScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

bool isLoginScreen = true;

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                textAlign: TextAlign.center,
                controller: _emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    final emailText = _emailController.text;
                    final isEmail = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(emailText);

                    (isEmail && _passwordController.text.isNotEmpty)
                        ? (isLoginScreen
                            ? loginButtonTapped(context)
                            : signupButtonTapped(context))
                        : (ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Enter valid credentials"),
                          )));
                  },
                  child: Text(isLoginScreen ? "SIGN IN" : "SIGN UP")),
              InkWell(
                child: Text(
                  "Forgot password",
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: forgotPassword,
              ),
              ElevatedButton(
                child: Text(isLoginScreen
                    ? "Account illenkl signup"
                    : "Account ondenkl Sign In"),
                onPressed: () {
                  setState(() {
                    isLoginScreen =
                        isLoginScreen ? !isLoginScreen : !isLoginScreen;
                  });
                },
              ),

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
                    onPressed: () {
                      signInWithGoogle(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/google24.png'),
                        Text(isLoginScreen
                            ? "Sign In using Google"
                            : "Sign Up using Google")
                      ],
                    )),
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.7,
              //   child: ElevatedButton(
              //       style: ButtonStyle(
              //           // padding: MaterialStateProperty.a,
              //           foregroundColor: MaterialStateProperty.all<Color>(
              //               AppColors.primaryColor),
              //           backgroundColor:
              //               MaterialStateProperty.all<Color>(Colors.white),
              //           shape:
              //               MaterialStateProperty.all<RoundedRectangleBorder>(
              //                   RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(18.0),
              //                       side: BorderSide(
              //                           color: AppColors.primaryColor)))),
              //       onPressed: () {
              //         signInWithGoogle(context);
              //         // .whenComplete(() {
              //         //   Navigator.of(context).push(MaterialPageRoute(
              //         //       builder: (context) => HomeScreen()));
              //         // });
              //       },
              //       child: Row(
              //         children: [
              //           Image.asset('assets/images/facebook24.png'),
              //           Text("Login using Facebook")
              //         ],
              //       )),
              // )
            ]),
      ),
    );
  }

///////////////
///////////////
///////////////////Email password auth
  Future loginButtonTapped(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    // if (await FirebaseAuth.instance.currentUser != null) {
    // signed in

    try {
      final UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // final User? user = FirebaseAuth.instance.currentUser;
      if (user.user != null) {
        createUser(user.user!, context);
      }
    } on Exception catch (exception) {
      if (exception is FirebaseAuthException) {
        if (exception.code == 'wrong-password') {
          Messages.displayMessage(context, "wrong password entered");
        } else if (exception.code == 'user-not-found') {
          Messages.displayMessage(context, "Sign Up First");
        }
      }
    }

    // final User? user = (await _auth.signInWithEmailAndPassword(
    //         email: email, password: password))
    //     .user;
    // if (user != null) {
    //   createUser(user, context);
    // }
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text("Create an account first"),
    //   ));
    // }
    //  else {
    // final User? user = (await _auth.createUserWithEmailAndPassword(
    //         email: email, password: password))
    //     .user;
    // if (user != null) {
    //   createUser(user, context);
    // }
    // }
  }

  Future signupButtonTapped(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    // if (await FirebaseAuth.instance.currentUser == null) {
    //   final User? user = (await _auth.createUserWithEmailAndPassword(
    //           email: email, password: password))
    //       .user;
    //   if (user != null) {
    //     createUser(user, context);
    //   }
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text("You already gave an account"),
    //   ));
    // }

////////////////
///////////////////
///////////////////

    // FirebaseAuth.instance
    //     .createUserWithEmailAndPassword(email: email, password: password);

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // final User? user = FirebaseAuth.instance.currentUser;

    } on Exception catch (exception) {
      if (exception is FirebaseAuthException) {
        if (exception.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("ALready logged in"),
          ));

          /// `foo@bar.com` has alread been registered.
        }
      }
    } catch (signUpError) {
      // if (signUpError is PlatformException) {
      //   if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
      //     (ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       content: Text("ALready logged in"),
      //     )));

      //     /// `foo@bar.com` has alread been registered.
      //   }
      // }
    }
  }

  Future forgotPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: "clal4252@gmail.com");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Mail send"),
    ));
  }

  ///////////////
///////////////
///////////////////Google auth

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
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
    createUser(user!, context);
  }

  Future<void> createUser(User currentUser, BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedKeys.loginStatus, true);
    prefs.setInt(SharedKeys.userAccess, 2);
    final databaseRef =
        FirebaseDatabase.instance.reference(); //database reference object
    await databaseRef
        .child(FirebaseKeys.users)
        .child(currentUser.uid)
        .once()
        .then((DataSnapshot snapshot) {
      // if (snapshot.value == null) {
      final userModel = UserModel(currentUser.email!, 2, false);
      databaseRef
          .child(FirebaseKeys.users)
          .child(currentUser.uid)
          .set(userModel.toJson())
          .whenComplete(() {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()));
      });
      // }
    });
  }
}

// class LoginScreen extends StatelessWidget {
  // const LoginScreen({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       width: double.infinity,
  //       child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             TextField(
  //               controller: _emailController,
  //               decoration: InputDecoration(hintText: 'Email'),
  //             ),
  //             TextField(
  //               controller: _passwordController,
  //               decoration: InputDecoration(
  //                 hintText: 'Password',
  //               ),
  //             ),
  //             ElevatedButton(
  //                 onPressed: () {
  //                   loginButtonTapped(context);
  //                 },
  //                 child: Text('Login')),

  //             // Login Button
  //             Container(
  //               width: MediaQuery.of(context).size.width * 0.7,
  //               child: ElevatedButton(
  //                   style: ButtonStyle(
  //                       // padding: MaterialStateProperty.a,
  //                       foregroundColor: MaterialStateProperty.all<Color>(
  //                           AppColors.primaryColor),
  //                       backgroundColor:
  //                           MaterialStateProperty.all<Color>(Colors.white),
  //                       shape:
  //                           MaterialStateProperty.all<RoundedRectangleBorder>(
  //                               RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(18.0),
  //                                   side: BorderSide(
  //                                       color: AppColors.primaryColor)))),
  //                   onPressed: () {
  //                     signInWithGoogle(context);
  //                   },
  //                   child: Row(
  //                     children: [
  //                       Image.asset('assets/images/google24.png'),
  //                       Text("Login using Google")
  //                     ],
  //                   )),
  //             ),
  //             // Container(
  //             //   width: MediaQuery.of(context).size.width * 0.7,
  //             //   child: ElevatedButton(
  //             //       style: ButtonStyle(
  //             //           // padding: MaterialStateProperty.a,
  //             //           foregroundColor: MaterialStateProperty.all<Color>(
  //             //               AppColors.primaryColor),
  //             //           backgroundColor:
  //             //               MaterialStateProperty.all<Color>(Colors.white),
  //             //           shape:
  //             //               MaterialStateProperty.all<RoundedRectangleBorder>(
  //             //                   RoundedRectangleBorder(
  //             //                       borderRadius: BorderRadius.circular(18.0),
  //             //                       side: BorderSide(
  //             //                           color: AppColors.primaryColor)))),
  //             //       onPressed: () {
  //             //         signInWithGoogle(context);
  //             //         // .whenComplete(() {
  //             //         //   Navigator.of(context).push(MaterialPageRoute(
  //             //         //       builder: (context) => HomeScreen()));
  //             //         // });
  //             //       },
  //             //       child: Row(
  //             //         children: [
  //             //           Image.asset('assets/images/facebook24.png'),
  //             //           Text("Login using Facebook")
  //             //         ],
  //             //       )),
  //             // )
  //           ]),
  //     ),
  //   );
  // }

  // Future loginButtonTapped(BuildContext context) async {
  //   final email = _emailController.text;
  //   final password = _passwordController.text;

  //   if (await FirebaseAuth.instance.currentUser != null) {
  //     // signed in
  //     final User? user = (await _auth.signInWithEmailAndPassword(
  //             email: email, password: password))
  //         .user;
  //     if (user != null) {
  //       createUser(user, context);
  //     }
  //   } else {
  //     final User? user = (await _auth.createUserWithEmailAndPassword(
  //             email: email, password: password))
  //         .user;
  //     if (user != null) {
  //       createUser(user, context);
  //     }
  //   }
  // }

  // Future<void> signInWithGoogle(BuildContext context) async {
  //   final GoogleSignInAccount? googleSignInAccount =
  //       await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount!.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //   final authResult = await _auth.signInWithCredential(credential);
  //   final User? user = authResult.user;
  //   assert(!user!.isAnonymous);
  //   assert(await user?.getIdToken() != null);
  //   final User currentUser = await _auth.currentUser!;
  //   assert(user?.uid == currentUser.uid);
  //   createUser(user!, context);
  // }

  // Future<void> createUser(User currentUser, BuildContext context) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(SharedKeys.loginStatus, true);
  //   prefs.setInt(SharedKeys.userAccess, 2);
  //   final databaseRef =
  //       FirebaseDatabase.instance.reference(); //database reference object
  //   await databaseRef
  //       .child(FirebaseKeys.users)
  //       .child(currentUser.uid)
  //       .once()
  //       .then((DataSnapshot snapshot) {
  //     if (snapshot.value == null) {
  //       final userModel = UserModel(currentUser.email!, 2, false);
  //       databaseRef
  //           .child(FirebaseKeys.users)
  //           .child(currentUser.uid)
  //           .set(userModel.toJson())
  //           .whenComplete(() {
  //         Navigator.of(context)
  //             .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  //       });
  //     }
  //   });
  // }
// }
