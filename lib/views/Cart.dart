import 'package:HUNGER/models/MealModel.dart';
import 'package:HUNGER/models/UserModel.dart';
import 'package:HUNGER/util/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CartPage extends HookWidget {

  Future<void> fetch(BuildContext context, ValueNotifier<List<MealModel>> meals) async {

    UserModel user = Provider.of<UserModel>(context);
    var response = await FirestoreHelper.firestore.collection("users/" + user.credential.user.uid + "/cart").get();
    List<MealModel> _meals = [];
    print(response.size);
    for (QueryDocumentSnapshot snapshot in response.docs) {
      DocumentSnapshot meal = await FirestoreHelper.firestore.doc("meals/" + snapshot.data()['meal_id']).get();
      _meals.add(MealModel.fromSnapshot(meal));
    }

    meals.value = _meals;

    print(_meals);
  }

  Widget build(BuildContext context) {
    var meals = useState<List<MealModel>>(null);

    useEffect(() {
      fetch(context, meals);
    }, []);

    return Scaffold(
      appBar: AppBar(),
      bottomSheet: new Container(
        height: 80,
        alignment: Alignment.center,
        child: new ElevatedButton(
          onPressed: () => {}, 
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))))
          ),
          child: new Container(
            padding: EdgeInsets.all(10),
            child: new Text(
              'Pay With Venmo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
            )
          )
        )
      ),
      body: new Container(
        padding: EdgeInsets.all(20),
        child: new Column(
          children: [
            new Container(
              child: new Text(
                'Cart',
                style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            new Container(
              height: 500,
              child: meals.value != null ? new ListView.builder(itemCount: meals.value.length + 1, itemBuilder: (BuildContext context, int index) {
                if (index == meals.value.length) {
                  return new Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => {Navigator.pushNamed(context, "/")},
                      child: new Container(
                        child: new Text(
                          '+ Meal',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  );
                } else {
                  return new Card(
                    margin: EdgeInsets.only(bottom: 15),
                    elevation: 10,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: new Container(
                      width: 70,
                      child: new Row(
                        children: [
                          Image.network(
                            meals.value.elementAt(index).imageURL,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover, 
                          ),
                          Gap(20),
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new Text(
                                meals.value.elementAt(index).name,
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              new Text(
                                meals.value.elementAt(index).type,
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  );
                }
              }) 
              : new CircularProgressIndicator(),
            ),
            
          ],
        )
      ),
    );
  }

}