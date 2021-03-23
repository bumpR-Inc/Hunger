
import 'package:HUNGER/components/Colors.dart';
import 'package:HUNGER/components/Logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final Widget bottomNavigationBar;
  final bool orderInProgress = false;

  MyScaffold({this.body, this.bottomNavigationBar});
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      appBar: new AppBar(
        title: orderInProgress ? 
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
            child: new Container(
              // color: Colors.red,
              padding: EdgeInsets.all(5),
              child: new Text(
                'Arriving in 9 minutes',
                style: TextStyle(color: MyColors.orange, fontSize: 20.0),
              ),
            ),
            onPressed: () => {},
          )
           : 
          new Logo(),
        backgroundColor: orderInProgress ? MyColors.orange : Colors.white,
        leading: IconButton(
          icon: Icon(Icons.person),
          color: orderInProgress ? Colors.white : Color(0xFFFF6B00),
          tooltip: 'Profile',
          onPressed: () => {
            Navigator.pushNamed(context, "/profile")
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            color: orderInProgress ? Colors.white : Color(0xFFFFA216),
            tooltip: 'Orders',
            onPressed: () => {},
          ),
        ],
      ),
      
    );
  }
}