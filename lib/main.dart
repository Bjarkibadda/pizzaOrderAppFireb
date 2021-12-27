import 'package:food_order_app/Widgets/main_widget.dart';
import 'package:flutter/material.dart';

import 'dart:io';

//List<dynamic> prdList = String<Post>.from(l.map((model)=> Post.fromJson(model)));
void main() => runApp(const MyApp());

class MyHttpOverrides extends HttpOverrides {
  // muna að breyta áður en gefið út. => https://stackoverflow.com/questions/54285172/how-to-solve-flutter-certificate-verify-failed-error-while-performing-a-post-req
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MainWidget(),
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],

          // Define the default font family.
          fontFamily: 'Georgia',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Hind',
                  fontWeight: FontWeight.bold),
              bodyText1: TextStyle(color: Colors.white)),
        ));
  }
}
