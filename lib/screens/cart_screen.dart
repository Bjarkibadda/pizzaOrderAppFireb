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
              const SizedBox(height: 20),
              Text('Pöntunin þín',
                  style: Theme.of(context).textTheme.headline4),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(15),
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Colors.orange),
                ),
                // color: Colors.orange.withOpacity(0.5)),
                child: Scrollbar(
                  isAlwaysShown: true,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('1x'),
                          Text(cartService.chartList[index].productName),
                          IconButton(
                              onPressed: () => {print('hello')},
                              icon: Icon(Icons.delete))
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
              TextButton(
                onPressed: () => {cartService.makeOrder()},
                child: const Text('Klára pöntun'),
              )
            ],
          );
        }));
  }
}
