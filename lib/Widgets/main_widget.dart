import 'package:flutter/material.dart';
import 'package:food_order_app/Models/product.dart';
import 'package:food_order_app/Models/menu_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../main.dart';
import 'dart:io';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  Future<List<Product>> fetchProducts() async {
    // ath eflaust algjör óþarfi að hafa þetta fall, hægt að kalla bara beint í fetchProducts.
    var myList = <
        Product>[]; // á eftir að fetcha lista af products úr api! þarf að mappa. Gert í Prodyuct klasanum
    return await IdProd(0).fetchProducts();
  }

  Future<List<MenuItem>> fetchMenu() async {
    HttpOverrides.global =
        MyHttpOverrides(); // muna að breyta, ef ég tek þetta út kemur villa! skoða.
    final response = await http.get(Uri.parse(('https://localhost:5001/Menu')));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var menu = (json.decode(response.body)['data'] as List)
          .map((data) => MenuItem.fromJson(data))
          .toList();
      return menu;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<List<MenuItem>> proddari = fetchMenu();
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: SizedBox(
                height: 45, child: Image.asset('Assets/Images/BBPizza.png'))),
        body: Column(
          children: [
            Expanded(
                child: SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: Align(
                alignment: Alignment.center,
                child: FutureBuilder<List<MenuItem>>(
                  // spurning hvort þetta ætti að vera sér widget! En þá þarf að finna út hvernig ég sendi gögnin með. Skoða codelab dæmið nr. 2
                  future: proddari,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                                height: 60,
                              ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              height: 250,
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        // 48, 47, 48
                                        20,
                                        20,
                                        20,
                                        0.8),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          offset: const Offset(0, 3),
                                          spreadRadius: 5,
                                          blurRadius: 6)
                                    ]),
                                child: Column(
                                  children: [
                                    Stack(
                                      fit: StackFit.loose,
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Positioned(
                                          top: -25,
                                          child: CircleAvatar(
                                            radius: 60.0,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: NetworkImage(
                                                snapshot.data![index].imageUrl),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text('3000 kr.'),
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 50,
                                                  width: 100,
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      itemCount: snapshot
                                                          .data![index]
                                                          .topics
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int idx) {
                                                        return Text(snapshot
                                                            .data![index]
                                                            .topics[idx]);
                                                      }),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 60,
                                      margin: const EdgeInsets.all(10.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.orange))),
                                    ),
                                    Text(snapshot.data![index].product,
                                        textAlign: TextAlign.right,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2)
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            )),
            Container(),
          ],
        ));
  }
}

// ListView.builder(
//                                                       shrinkWrap: true,
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8),
//                                                       itemCount: snapshot
//                                                           .data![index]
//                                                           .topics
//                                                           .length,
//                                                       itemBuilder:
//                                                           (BuildContext context,
//                                                               int idx) {
//                                                         return Container(
//                                                           height: 10,
//                                                           child: Center(
//                                                               child: Text(snapshot
//                                                                   .data![index]
//                                                                   .topics[idx])),
//                                                         );
