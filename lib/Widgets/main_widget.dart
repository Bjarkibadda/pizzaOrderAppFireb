import 'package:flutter/material.dart';
import 'package:food_order_app/Models/product.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  Future<List<Product>> fetchProducts() async {
    // ath eflaust algjör óþarfi að hafa þetta fall, hægt að kalla bara beint í fetchProducts.
    var myList = <
        Product>[]; // á eftir að fetcha lista af products úr api! þarf að mappa. Gert í Prodyuct klasanum
    var myProducts = await IdProd(0).fetchProduct();
    myList.add(myProducts);
    myList.add(myProducts);
    return myList;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Product>> proddari = fetchProducts();
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
                child: Align(
              alignment: Alignment.center,
              child: FutureBuilder<List<Product>>(
                future: proddari,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                              child: Container(
                                  margin: const EdgeInsets.all(20),
                                  height: 350,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 7.0,
                                            spreadRadius: 5.0,
                                            offset: const Offset(0, 3),
                                            color:
                                                Colors.pink.withOpacity(0.1)),
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.transparent),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Image.network(
                                              snapshot.data![index].imgUrl,
                                            )),
                                        const SizedBox(height: 10),
                                        Text(snapshot.data![index].name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17))

                                        //Text(snapshot.data![index].name),
                                        ,
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Hello"),
                                            Text("World"),
                                            Text("ekki?")
                                          ],
                                        )
                                      ])));
                        });
                  }
                  return const CircularProgressIndicator();
                },
              ),
            )),
            Container(),
          ],
        ));
  }
}
