import 'package:food_order_app/Providers/Order_cart_service.dart';
import 'package:food_order_app/Widgets/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/screens/cart_screen.dart';
import 'package:food_order_app/screens/main_screen.dart';

import 'dart:io';

import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => OrderChartService())],
    child: MyApp()));

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
        initialRoute: ('/'),
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => MainScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/cart': (context) => CartScreen(),
          '/menu': (context) => const MainWidget(),
        },
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],

          // Define the default font family.
          fontFamily: 'Georgia',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
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
