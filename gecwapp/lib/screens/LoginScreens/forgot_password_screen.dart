import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:gecwapp/screens/LoginScreens/loginScreen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  // const ForgotPasswordScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          width: double.infinity,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spac,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Image.asset(
                'assets/images/forgot-password.jpg',
                width: screenWidth * 0.7,
                // height: screenHeight * 0.7,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "Forgot \nPassword",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 15),
                child: Text(
                  "Enter mail id you previosly logged in. A link to rest the password will be send to you.",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: screenWidth * 0.9,
                child: CustomTextField("Email id", _emailController,
                    Icon(Icons.alternate_email), false),
              ),
              SizedBox(
                height: 35,
              ),
              RoundedButton("Submit", (() {
                forgotPassword(context);
              }), screenWidth * 0.8, screenHeight * 0.06)
            ],
          )),
    );
  }

  Future forgotPassword(BuildContext context) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: "clal4252@gmail.com");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Mail send"),
    ));
  }
}
