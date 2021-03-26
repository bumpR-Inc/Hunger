import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:progress_indicators/progress_indicators.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  Widget build(BuildContext context) {
    List<Map<String, dynamic>> messages = [
      {'message': 'Hey your food is here', 'bot': true},
      {'message': 'Hey your food is here', 'bot': true},
      {'message': 'Hey your food is here', 'bot': false},
      {'message': 'Hey your food is here', 'bot': true},
      {'message': 'Hey your food is here', 'bot': true},
      {'message': 'Hey your food is here', 'bot': true},
      {'message': 'Hey your food is here', 'bot': false},
      {'message': 'Hey your food is here', 'bot': true},
      {'message': 'Hey your food is here', 'bot': true, 'loading': true},
    ];

    return Scaffold(
      body: new Container(
        child: new Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height*0.9,
              child: new ListView.builder(itemCount: messages.length, itemBuilder: (BuildContext context, int index) {
                return DelayedDisplay(
                  delay: Duration(seconds: index),
                  child: new Container(
                    padding: EdgeInsets.only(bottom: 5),
                    width: MediaQuery.of(context).size.width, 
                    child: new Row(
                      mainAxisAlignment: messages.elementAt(index)['bot'] ? MainAxisAlignment.start : MainAxisAlignment.end,
                      children: [
                        new Card(
                          color: messages.elementAt(index)['bot'] ? Colors.blueGrey.shade100 : Colors.orange,
                          child: new Container(
                            constraints: BoxConstraints(maxWidth: 250),
                            padding: EdgeInsets.all(10),
                            child: messages.elementAt(index)['loading'] ?? false 
                              ? new Container(
                                width: 30,
                                child: JumpingDotsProgressIndicator(
                                  fontSize: 20,
                                ) ,
                              )
                              : new Text(
                                messages.elementAt(index)['message'],
                                maxLines: 100,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: messages.elementAt(index)['bot'] ? Colors.black : Colors.white),
                              )
                          )
                        )
                      ]
                    )
                  )
                );
              }),
            ),
            Container(
              color: Colors.orange,
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height*0.1,
              child: new TextField(
                onChanged: (String text) => {},
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  icon: Icon(Icons.send),
                  hintText: 'Hint Text',
                  border: OutlineInputBorder(),
                ),
              )
            )
          ],
        )
      ),
    );
  }

}