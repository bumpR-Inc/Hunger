import 'package:HUNGER/util/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:HUNGER/components/Logo.dart';
import 'package:HUNGER/components/MealCard.dart';
import 'package:HUNGER/models/MealModel.dart';

class HomePage extends HookWidget {
  // QueryDocumentSnapshot lastSnapshot;

  Future<void> getData(ValueNotifier mealsState, ValueNotifier loadingState) async {
    QuerySnapshot raw;
    // if (lastSnapshot == null) {
    raw = await FirestoreHelper.firestore.collection('meals').get();
    // } else {
    //   print('update');
    //   raw = await FirestoreHelper.firestore.collection('meals').limit(5).startAfterDocument(lastSnapshot).get();
    // }

    // List<MealModel> meals = [];
    // meals.addAll(mealsState.value);
    Iterator<QueryDocumentSnapshot> data_iterator = raw.docs.iterator;

    QueryDocumentSnapshot snapshot;
    while (data_iterator.moveNext()) {
      snapshot = data_iterator.current;
      mealsState.value.add(MealModel.fromJson(snapshot.data()));
    }

    // lastSnapshot = snapshot;
    // mealsState.value = meals; 
    loadingState.value = false;

    // if (raw.docs.length < 5) {
    //   lastSnapshot = null;
    //   getData(mealsState, loadingState);
    // }
  }

  @override
  Widget build(BuildContext context) {
    CardController controller = new CardController(); //Use this to trigger swap.
    final loading = useState<bool>(true);
    final meals = useState<List<MealModel>>([]);
    final size = useState<int>(10);

    useEffect(() {
      getData(meals, loading);
    }, []);

    // final checkRefresh = () {
    //   if (meals.value.length == 2) {
    //     getData(meals, loading);
    //   }
    // };

    Widget tinder = new TinderSwapCard(
              swipeUp: false,
              swipeDown: false,
              orientation: AmassOrientation.BOTTOM,
              totalNum: size.value,
              stackNum: 3,
              swipeEdge: 4.0,
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              minHeight: MediaQuery.of(context).size.height * 0.65,
              cardBuilder: (context, index) => new MealCard(meals.value.elementAt(index % 10)),
              cardController: controller = controller,
              swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
                // if (align.x != 0) {
                //   checkRefresh();
                // }
                if (align.x < 0) { //left
                
                } else if (align.x > 0) { //right
                
                }
              },
              swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
                  if (orientation.index == meals.value.length) {
                    size.value += 1;
                  }
                  /// Get orientation & index of swiped card!
                },
          );

    return new Scaffold(
      appBar: new AppBar(
        title: new Logo(),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.person),
          color: Color(0xFFFF6B00),
          tooltip: 'Profile',
          onPressed: () => {
            Navigator.pushNamed(context, "/profile")
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            color: Color(0xFFFFA216),
            tooltip: 'Orders',
            onPressed: () => {},
          ),
        ],
      ),
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
      body: new Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
          height: MediaQuery.of(context).size.height * 1,
          child: loading.value ? 
            new CircularProgressIndicator() : tinder
        ),
      );
  }
}