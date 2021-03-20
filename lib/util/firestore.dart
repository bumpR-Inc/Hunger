import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static FirebaseFirestore firestore;

  static void initialize() {
    firestore = FirebaseFirestore.instance;
  }
}
