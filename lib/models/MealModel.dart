import 'package:HUNGER/models/UserModel.dart';
import 'package:HUNGER/util/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class MealModel {
  String id;
  String imageURL;
  String name;
  String type;

  MealModel(this.name, this.type, this.imageURL);

  MealModel.fromSnapshot(DocumentSnapshot snapshot):
    id = snapshot.id,
    imageURL = snapshot.data()['image_url'],
    name = snapshot.data()['name'],
    type = snapshot.data()['type'];
    

  Future<void> registerSwipe(bool ordered, BuildContext context) async {
    UserModel user = Provider.of<UserModel>(context, listen: false);
    var response = await FirestoreHelper.firestore.doc("users/" + user.credential.user.uid + "/swipes/" + id).set({
      'datetime': FieldValue.serverTimestamp(),
      'ordered': ordered,
      'meal_id': id,
    });

    if (ordered) {
      UserModel user = Provider.of<UserModel>(context, listen: false);
      response = await FirestoreHelper.firestore.doc("users/" + user.credential.user.uid + "/cart/" + id).set({
        'meal_id': id,
        'quantity': 1,
      });
    }
  }

  static MealModel test() {
    return MealModel(lipsum.createWord(numWords: 2), lipsum.createWord(numWords: 2), "https://www.baking-sense.com/wp-content/uploads/2020/06/hot-dog-rolls-10a.jpg");
  }

}