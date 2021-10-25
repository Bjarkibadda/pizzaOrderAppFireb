// // Copyright 2018 The Flutter team. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// import 'package:flutter/material.dart';
// import 'package:food_order_app/testList.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Welcome to Flutter',
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Welcome to Flutter'),
//           ),
//           body: ListView(
//             children: [
//               Container(
//                 alignment: Alignment.center,
//                 height: 50,
//                 child: const Text('Gamli'),
//                 color: Colors.green,
//               ),
//               Container(
//                   height: 100,
//                   child: const Text('Pungur'),
//                   color: Colors.brown),
//               Container(
//                   child: const Text('Blessaður'),
//                   height: 200,
//                   color: Colors.deepOrange)
//             ],
//           )),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'dart:math';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

List<Color> colorsList = [Colors.black, Colors.blue, Colors.pink, Colors.grey];

Color GetColor() {
  return colorsList[new Random().nextInt(colorsList.length)];
}

Future<String> getData() async {
  print("10.02 maður?");
  final url = Uri.parse('https://localhost:5001/Product');
  http.Response response = await http.get(url);
  print(response.body.toString());
  print(response);

  return response.body;
}

Future<List<ProductList>> fetchAlbum() async {
  HttpOverrides.global = MyHttpOverrides();

  final response = await http.get(Uri.parse('https://localhost:5001/Product'));

  var myList = (json.decode(response.body)['data'] as List)
      .map((data) => ProductList.fromJson(data))
      .toList();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return myList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

final url = Uri.parse('https://10.0.2.2:5001/Product');

class ProductList {
  final int id;
  final String name;
  final int price;
  final String imgUrl;
  final String topics;

  ProductList(
      {required this.id,
      required this.name,
      required this.price,
      required this.imgUrl,
      required this.topics});
  factory ProductList.fromJson(Map<String, dynamic> json) {
    return ProductList(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        imgUrl: json['imgUrl'],
        topics: json['topics']);
  }
}

class Product {
  final List<dynamic> myData;
  final bool success;
  final String message;

  Product({required this.myData, required this.success, required this.message});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      myData: json['data'],
      success: json['success'],
      message: json['message'],
    );
  }
}

//List<dynamic> prdList = String<Post>.from(l.map((model)=> Post.fromJson(model)));
void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<ProductList>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<ProductList>>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: double.infinity / 2,
                  width: double.infinity / 2,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 10,
                          shadowColor: Colors.white,
                          child: SizedBox(
                            height: 300,
                            width: 90,
                            child: ClipRRect(
                              child: SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: GridTile(
                                    header: Center(
                                        child: Text(
                                      snapshot.data![index].name,
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 50),
                                    )),
                                    child: Image.network(
                                        snapshot.data![index].imgUrl,
                                        fit: BoxFit.fitWidth),
                                  )),
                            ),
                          ),
                        );
                        //snapshot.data![index].name);
                      }),
                );

                //ListView.builder((snapshot.data![0].name);
              } else if (snapshot.hasError) {
                return Text('${getData()}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
