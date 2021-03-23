import 'package:HUNGER/components/Colors.dart';
import 'package:HUNGER/models/UserModel.dart';
import 'package:auth_buttons/res/buttons/google_auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Login extends HookWidget {
  Future<void> signInWithGoogle(BuildContext context, UserModel user) async {
    FirebaseAuth.instance.signInWithPhoneNumber("3173790645");
    // final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    // user.firstSignIn(googleAuth);
  }

  @override
  Widget build(BuildContext context) {    
    UserModel user = Provider.of<UserModel>(context);
    return new Scaffold(
      body: new Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [MyColors.darkOrange, MyColors.lightOrange])),
        width: MediaQuery.of(context).size.width,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Image(
              image: AssetImage("assets/images/full-logo.png"),
              width: 325,
              fit: BoxFit.cover,
            ),
            Gap(15),
            GoogleAuthButton(
              textStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 21),
              onPressed: () => {
                signInWithGoogle(context, user)
              },
            )
          ]
        )
      ),
    );
  }
}