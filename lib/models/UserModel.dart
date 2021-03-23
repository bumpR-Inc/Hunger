import 'package:HUNGER/util/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';


class UserModel with ChangeNotifier {
  UserCredential credential;
  String _accessToken;
  String _idToken;

  void recover() async {
    Map<String, dynamic> stored = Storage.fetch("user");
    print(stored);
    if (stored != null) {
      _accessToken = stored['accessToken'];
      _idToken = stored['idToken'];
      await signIn();
    }
  }

  void store() {
    Map<String, dynamic> json = {
      'accessToken': _accessToken,
      'idToken': _idToken,
    };
    print("storing");
    Storage.store("user", json);
  }

  void firstSignIn(GoogleSignInAuthentication googleAuth) {
    _accessToken = googleAuth.accessToken;
    _idToken = googleAuth.idToken;
    store();

    signIn();
  }

  void signIn() async {
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: _accessToken,
      idToken: _idToken,
    );

    try {
      this.credential = await FirebaseAuth.instance.signInWithCredential(credential);
    } catch(e) {
      
    }
    notifyListeners();
  }


}