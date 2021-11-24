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
    return const MaterialApp(home: MainWidget());
  }
}
