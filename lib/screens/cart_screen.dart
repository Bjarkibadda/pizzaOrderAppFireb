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
                      var menuItem = cartService.chartList[index];
                      var isMultiple = cartService.chartList[index].count > 1;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                padding: EdgeInsets.all(1),
                                icon: const Icon(Icons.arrow_upward,
                                    color: Colors.green),
                                onPressed: () =>
                                    {cartService.addToCount(menuItem)},
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_downward,
                                    color: Colors.deepOrange),
                                onPressed: () =>
                                    {cartService.lowerCount(menuItem)},
                              ),
                            ],
                          ),
                          Text("${menuItem.count}x"),
                          Text(menuItem.productName),
                          IconButton(
                              onPressed: () => {
                                    cartService.deleteFromOrder(
                                        cartService.chartList[index])
                                  },
                              icon: const Icon(Icons.delete))
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
