import 'package:HUNGER/components/Colors.dart';
import 'package:HUNGER/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProfilePage extends HookWidget {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        // shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.orange,
          tooltip: 'Back',
          onPressed: () => {
            Navigator.pop(context)
          },
        ),
      ),
      body: new Column(
        children: [
          new Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [MyColors.darkOrange, MyColors.lightOrange])),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*1/4,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(Provider.of<UserModel>(context).credential.user.photoURL),
                  radius: MediaQuery.of(context).size.width*0.15,
                ),
                new Gap(10),
                new Text(
                  Provider.of<UserModel>(context).credential.user.displayName,
                  style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
          new Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            // height: double.infinity,
          )
        ],
      ),
    );
  }
}