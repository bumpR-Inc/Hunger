import 'package:HUNGER/components/Webview.dart';
import 'package:HUNGER/models/User.dart';
import 'package:HUNGER/util/firestore.dart';
import 'package:HUNGER/util/storage.dart';
import 'package:HUNGER/views/ProfilePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:HUNGER/views/Home.dart';
import 'package:HUNGER/views/Login.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Storage.initialize();

  UserModel user = new UserModel();
  await user.recover();
  FirestoreHelper.initialize();

  DocumentSnapshot config = await FirestoreHelper.firestore.collection('docs').doc("config").get();
  String webview = config.data()['webview'];

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => user),
      ],
      child: MyApp(webview),
    )
  );
}

class MyApp extends HookWidget {
  String webview;

  MyApp(this.webview);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: webview == "" ? 
        (Provider.of<UserModel>(context).credential != null ? HomePage() : Login()) :
        MyWebview(webview)
        ,
      routes: {
        // '/': (context) => new Container(child: new Text('hi')),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

