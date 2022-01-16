import 'package:flutter/material.dart';
import 'package:food_order_app/Providers/Order_cart_service.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: SizedBox(
                height: 45, child: Image.asset('Assets/Images/BBPizza.png'))),
        body:
            Consumer<OrderChartService>(builder: (context, cartService, child) {
          if (cartService.isCartEmpty()) {
            return const Center(child: Text('Engin vara í körfu'));
          }
          return Column(
            children: [
              const SizedBox(height: 35),
              Text('Pöntunin þín',
                  style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Colors.orange),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Scrollbar(
                        isAlwaysShown: true,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            var menuItem = cartService.chartList[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("${menuItem.count16}x"),
                                Text(menuItem.productName),
                                Text(
                                    "${menuItem.price * menuItem.count16} kr."),

                                //  print("The concatenated string : ${res}")
                                IconButton(
                                    onPressed: () => {
                                          cartService.deleteFromOrder(
                                              cartService.chartList[index])
                                        },
                                    icon: const Icon(Icons.delete)),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: 20,
                          ),
                          itemCount: cartService.chartList.length,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.orange.withOpacity(0.4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Heildarverð",
                              style: Theme.of(context).textTheme.headline6),
                          const SizedBox(width: 10),
                          Text(cartService.totalPrice().toString() + " kr.")
                        ],
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () => {cartService.makeOrder()},
                child: const Text('Klára pöntun'),
              )
            ],
          );
        }));
  }
}
