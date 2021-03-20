import 'package:HUNGER/models/User.dart';
import 'package:HUNGER/util/firestore.dart';
import 'package:HUNGER/util/storage.dart';
import 'package:HUNGER/views/ProfilePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:HUNGER/views/Home.dart';
import 'package:HUNGER/views/Login.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Storage.initialize();

  UserModel user = new UserModel();
  await user.recover();
  FirestoreHelper.initialize();

  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => user),
    ],
    child: MyApp(),
  ));
}

class MyApp extends HookWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Provider.of<UserModel>(context).credential != null ? HomePage() : Login(),
      routes: {
        // '/': (context) => new Container(child: new Text('hi')),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

