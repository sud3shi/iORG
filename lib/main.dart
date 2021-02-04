import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iorg_flutter/BottomAnimatedBarExample.dart';
import 'package:iorg_flutter/pages/ArchivePage.dart';
import 'package:iorg_flutter/pages/CreatePostPage.dart';
import 'package:iorg_flutter/pages/HomePage.dart';
import 'package:iorg_flutter/pages/InitPage.dart';
import 'package:statusbar/statusbar.dart';

import 'ControllerExample.dart';

bool usingEmulator = false;
final StorageReference storageReference =
    FirebaseStorage.instance.ref().child("Posted Pictures");
final postReference = FirebaseFirestore.instance.collection("posts");
final userReference = FirebaseFirestore.instance.collection("users");
DateTime backButtonPressedTime;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (usingEmulator) {
    FirebaseFirestore.instance.settings = Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Hexcolor(getAccentColorHexVal()),
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Hexcolor(getAccentColorHexVal()),
  ));

  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StatusBar.color(Hexcolor(getAccentColorHexVal()));
    return MaterialApp(
      title: getApplicationTitle(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: myAccentColor,
        dialogBackgroundColor: Colors.white,
        primarySwatch: Colors.blueGrey,
        cardColor: Colors.white70,
        accentColor: myAccentColor,
        textTheme: TextTheme(
          button: TextStyle(
            fontSize: 15.0,
            // color: Colors.white,
            color: myAccentColor,
          ),
          headline5: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          bodyText1: TextStyle(
            fontSize: 10.0,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      initialRoute: '/init',
      routes: <String, WidgetBuilder>{
        '/init': (BuildContext context) => InitPage(),
        // '/home': (BuildContext context) => HomePage(),
        '/archive': (BuildContext context) => ArchivePage(),
        '/create': (BuildContext context) => CreatePostPage(),
        // '/bottomBarExample': (BuildContext context) => BottomAnimatedBarExamplePage(),
        '/controller': (BuildContext context) => ControllerExample(),
      },
    );
  }
}

String getApplicationTitle() {
  return "iORG";
}

String getAccentColorHexVal() {
  return "#8777ac";
}

returnPriorityColor(double val) {
  return val == 1
      ? Colors.green[200]
      : val == 2
          ? Colors.yellow[200]
          : val == 3
              ? Colors.red[200]
              : Colors.grey[200];
}

Color get success => const Color(0xFF28a745);

Color get info => const Color(0xFF17a2b8);

Color get warning => const Color(0xFFffc107);

Color get danger => const Color(0xFFdc3545);

Color get mySixtyNineColor => const Color.fromARGB(255, 105, 105, 105);

Color get myAccentColor => const Color.fromARGB(255, 135, 119, 172);

TextStyle get error => const TextStyle(
    decoration: TextDecoration.lineThrough,
    fontSize: 20.0,
    color: Colors.blue,
    fontWeight: FontWeight.bold);

TextStyle get myLinkBodyTextStyle => const TextStyle(
    color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold);

TextStyle get myLinkTextStyle => const TextStyle(
      color: Colors.blue,
    );

TextStyle get subBodyTitle => const TextStyle(
      color: Colors.white,
      fontSize: 13.0,
      fontWeight: FontWeight.bold,
    );
