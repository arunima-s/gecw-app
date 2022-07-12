import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/userModel.dart';
import 'package:gecwapp/Utilities/popup_messages.dart';
import 'package:gecwapp/customWidgets/overlayLoader.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:gecwapp/screens/LoginScreens/forgot_password_screen.dart';
import 'package:gecwapp/screens/homeScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

bool isLoggingIn = false;
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),

                    // SizedBox(
                    //   width: loginAnimation!.value,
                    // ),
                    Image.asset(
                      'assets/images/loginScreenImage.jpg',
                      // width: screenWidth * 0.3,
                      width: screenWidth * 0.7,
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.06,
                        ),
                        Text(
                          isLoginScreen ? "Sign in" : "Sign up",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // Text("Login using your mail id"),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    SizedBox(
                      height: screenHeight * 0.08,
                      width: screenWidth * 0.9,
                      child: CustomTextField("Email Id", _emailController,
                          Icon(Icons.alternate_email_rounded), false),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: screenHeight * 0.08,
                      width: screenWidth * 0.9,
                      child: CustomTextField("Password", _passwordController,
                          Icon(Icons.lock), true),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Text(
                            "Forgot password",
                            style: TextStyle(color: Colors.blue),
                          ),
                          // onTap: forgotPassword,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen()));
                          },
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       final emailText = _emailController.text;
                    //       final isEmail = RegExp(
                    //               r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //           .hasMatch(emailText);

                    //       (isEmail && _passwordController.text.isNotEmpty)
                    //           ? (isLoginScreen
                    //               ? loginButtonTapped(context)
                    //               : signupButtonTapped(context))
                    //           : (ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //               content: Text("Enter valid credentials"),
                    //             )));
                    //     },
                    //     child: Text(isLoginScreen ? "SIGN IN" : "SIGN UP")),

                    //////
                    RoundedButton(isLoginScreen ? "SIGN IN" : "SIGN UP", (() {
                      final emailText = _emailController.text;

                      final isEmail = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(emailText);

                      (isEmail && _passwordController.text.isNotEmpty)
                          ? (isLoginScreen
                              ? loginButtonTapped(context)
                              : signupButtonTapped(context))
                          : (ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                              content: Text("Enter valid credentials"),
                            )));
                    }), screenWidth * 0.8, screenHeight * 0.06),

                    SizedBox(
                      height: screenHeight * 0.01,
                    ),

                    Text(
                      "OR",
                      style: TextStyle(color: Colors.grey),
                    ),

                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    ////
                    // Login Button
                    SizedBox(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              // padding: MaterialStateProperty.a,
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.primaryColor),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
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
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Does'nt have an account?  "),
                        InkWell(
                          child: Text(
                            isLoginScreen ? "Register" : "Login",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            setState(() {
                              isLoginScreen = isLoginScreen
                                  ? !isLoginScreen
                                  : !isLoginScreen;
                            });
                          },
                        ),
                      ],
                    ),
                    // ElevatedButton(
                    //   child: Text(isLoginScreen
                    //       ? "Account illenkl signup"
                    //       : "Account ondenkl Sign In"),
                    //   onPressed: () {
                    //     setState(() {
                    //       isLoginScreen =
                    //           isLoginScreen ? !isLoginScreen : !isLoginScreen;
                    //     });
                    //   },
                    // ),
                    //
                  ]),
            ),
          ),
          isLoggingIn ? LoaderTransparent() : Container()
        ],
      ),
    );
  }

///////////////
///////////////
///////////////////Email password auth
  Future loginButtonTapped(BuildContext context) async {
    setState(() {
      isLoggingIn = true;
    });
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
  }

  Future signupButtonTapped(BuildContext context) async {
    setState(() {
      isLoggingIn = true;
    });
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
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
      //     /// `foo@bar.com` has alread been registered.
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

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController _controller;
  final Icon _icon;
  final bool isPassword;
  CustomTextField(this.text, this._controller, this._icon, this.isPassword);
  // const CustomTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      controller: _controller,
      decoration: InputDecoration(
          prefixIcon: _icon,
          suffixIcon: isPassword ? Icon(Icons.remove_red_eye_outlined) : null,
          hintText: text,
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                  width: 1, color: Color.fromARGB(255, 189, 189, 189)))),
    );
  }
}
