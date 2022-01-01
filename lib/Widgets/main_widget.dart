import 'package:flutter/material.dart';
import 'package:food_order_app/Models/product.dart';
import 'package:food_order_app/Models/menu_item.dart';
import 'package:food_order_app/Providers/Order_cart_service.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
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
              height: 45, child: Image.asset('Assets/Images/BBPizza.png')),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/cart'),
                  child: const Icon(
                    Icons.shopping_basket,
                    color: Colors.orange,
                  )),
            )
          ],
        ),
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
                                            Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Price_Column(),
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
                                                            .topics
                                                            .values
                                                            .toList()[idx]
                                                            .toString());
                                                      }),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 15,
                                      margin: const EdgeInsets.all(5.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.orange))),
                                    ),
                                    Text(snapshot.data![index].productName,
                                        textAlign: TextAlign.right,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                    Container(
                                        margin: const EdgeInsets.all(10),
                                        child: Text(
                                          snapshot.data![index].description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    AddToCartButton(
                                        snapshot: snapshot.data![index])
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

class AddToCartButton extends StatefulWidget {
  final MenuItem snapshot;

  //const AddToCartButton({required this.snapshot});

  const AddToCartButton({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

bool tapped = false;

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderChartService>(builder: (context, chartService, child) {
      return GestureDetector(
        onTapDown: (_) {
          setState(() {
            tapped = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            tapped = false;
          });
        },
        onTap: () => chartService.addToChart(widget.snapshot),
        child: Container(
          decoration: BoxDecoration(
              color: tapped
                  ? Colors.orange.withOpacity(0.7)
                  : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Colors.orange)),
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Bæta við pöntun"),
              const SizedBox(
                width: 10,
              ),
              const Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.orange,
                  )),
            ],
          ),
        ),
      );
    });
  }
}

// setja í nýjan file
class Price_Column extends StatefulWidget {
  const Price_Column({
    Key? key,
  }) : super(key: key);

  @override
  State<Price_Column> createState() => _Price_ColumnState();
}

class _Price_ColumnState extends State<Price_Column> {
  bool size = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(size ? '3000 kr.' : '2000 kr.'),
        Row(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text('12"'),
            Transform.scale(
              scale: 0.7,
              child: Switch.adaptive(
                  value: size,
                  onChanged: (size) => setState(() => this.size = size)),
            ),
            const Text('16"')
          ],
        ),
      ],
    );
  }
}
