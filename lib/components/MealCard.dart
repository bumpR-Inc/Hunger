import 'package:flutter/material.dart';
import 'package:HUNGER/models/MealModel.dart';

class MealCard extends StatelessWidget {
  MealModel meal; 

  MealCard(this.meal);

  @override
  Widget build(BuildContext context) {
    return new Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: new Container(
        child: new Stack(children: [
          new Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(meal.imageURL,),
                fit: BoxFit.cover,
              )
            ),
          ),
          new Container(
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.5),
                    ],
                    stops: [
                      0.0,
                      0.6,
                      1.0
                    ])),
          ),
          new Container(
            padding: EdgeInsets.all(20),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(child: new Text(
                  meal.name,
                  style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                )),
                new Container(child: new Text(
                  meal.type,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ))
              ],
            ),
          ),
        ],)
        // clipBehavior: Clip.hardEdge,
      ),
    );
  }
}