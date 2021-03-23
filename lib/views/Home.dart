// support for asynchronous data events
import 'dart:async';
import 'dart:math';

import 'package:HUNGER/components/Colors.dart';
import 'package:HUNGER/components/Logo.dart';
import 'package:HUNGER/components/MealCard.dart';
import 'package:HUNGER/components/MyScaffold.dart';
import 'package:HUNGER/components/SwipeCard.dart';
import 'package:HUNGER/models/MealModel.dart';
import 'package:HUNGER/util/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeAsync extends StatefulWidget {
  @override
  _HomeAsyncState createState() =>
      _HomeAsyncState();
}

class _HomeAsyncState extends State<HomeAsync>
    with TickerProviderStateMixin {
  StreamController<Map<int, MealModel>> _streamController;
  CardController controller = new CardController(); //Use this to trigger swap.

  QueryDocumentSnapshot lastSnapshot;
  final int numInitialData = 5;
  int dataIndex = 0;
  Map<int, MealModel> meals = new Map<int, MealModel>();
  int index = 0;

  @override
  Widget build(BuildContext context) {

    return new MyScaffold(
      bottomNavigationBar: new BottomNavigationBar(items: [
        new BottomNavigationBarItem(
          icon: new Icon(Icons.cancel),
          label: "nah",
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.check),
          label: "fasho"
        )
      ],
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.green,
      iconSize: 40,
      onTap: (value) {
        // checkRefresh();
        if (value == 0) {
          controller.triggerLeft();
        } else {
          controller.triggerRight();
        }
      },),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: new ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () => {},
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Icon(
                    Icons.location_on,
                    color: MyColors.orange,
                  ),
                  Gap(5),
                  new Text(
                    "2216 Channing Way, Berkeley CA, 94704",
                    style: TextStyle(color: MyColors.orange, fontSize: 15),
                  )
                ],
              )
            ),
          ),
          new Gap(0),
          new Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.73,
            child: StreamBuilder<Map<int, MealModel>>(
              stream: _streamController.stream,
              initialData: meals,
              builder:
                  (BuildContext context, AsyncSnapshot<Map<int, MealModel>> snapshot) {
                    if (meals.length == 0) return CircularProgressIndicator();
                    if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                    if (snapshot.connectionState == ConnectionState.active) {
                      print("build active");
                      return _Stack(context, snapshot.data);
                    }
                    return null; // unreachable
              },
            ),
          ),
        ]
      )
    );
  }

  @override
  initState() {
    super.initState();
    _streamController = StreamController<Map<int, MealModel>>();
    _addToStream();
  }

  void _addToStream() async {
    bool x = false;
    QuerySnapshot raw;
    if (lastSnapshot == null) {
      raw = await FirestoreHelper.firestore.collection('meals').limit(this.numInitialData).get();

      Iterator<QueryDocumentSnapshot> data_iterator = raw.docs.iterator;
      while (data_iterator.moveNext()) {
        lastSnapshot = data_iterator.current;
        MealModel model = MealModel.fromSnapshot(lastSnapshot);
        meals[this.dataIndex] = model;
        this.dataIndex++;
      }
    } else {
      raw = await FirestoreHelper.firestore.collection('meals').limit(1).startAfterDocument(lastSnapshot).get();
      print(raw.docs.first.data());
      if (raw.docs.length == 0) {
        raw = await FirestoreHelper.firestore.collection('meals').limit(1).get();
      }

      lastSnapshot = raw.docs.first;
      print(lastSnapshot.id);
      MealModel model = MealModel.fromSnapshot(lastSnapshot);
      meals[this.dataIndex] = model;
      // meals.remove(this.dataIndex-this.numInitialData-1);
      this.dataIndex++;
    }
    
    _streamController.add(meals);
  }

  Widget _Stack(BuildContext context, Map<int, MealModel> meals) {
    print(meals);
    return new Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
      child: TinderSwapCard(
        swipeUp: false,
        swipeDown: false,
        orientation: AmassOrientation.BOTTOM,
        totalNum: dataIndex + numInitialData,
        stackNum: 3,
        swipeEdge: 4.0,
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height * 0.7,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        minHeight: MediaQuery.of(context).size.height * 0.65,
        cardBuilder: (context, offset) {
          print(this.index + offset);
          // print(this.dataIndex - this.numInitialData);
          // print(meals[this.dataIndex - this.numInitialData]);
          return new MealCard(meals[this.index + offset]);
        },
        cardController: controller,
        swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
          /// Get swiping card's alignment
          if (align.x < 0) {
            //Card is LEFT swiping
          } else if (align.x > 0) {
            //Card is RIGHT swiping
          }
        },
        swipeCompleteCallback: (CardSwipeOrientation orientation, int offset) {
          _addToStream();
          this.index++;

          meals[this.index + offset].registerSwipe(orientation == CardSwipeOrientation.RIGHT, context);
          /// Get orientation & index of swiped card!
        },
      )
    );
  }
}