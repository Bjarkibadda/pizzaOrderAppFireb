import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_order_app/Providers/Order_cart_service.dart';
import 'package:badges/badges.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderChartService>(builder: (context, cartService, child) {
      return AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(
            height: 45, child: Image.asset('Assets/Images/BBPizza.png')),
        actions: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 20, 0),
              child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/cart'),
                  child: Badge(
                    badgeContent: Text(cartService.itemCount().toString()),
                    child: const Icon(Icons.shopping_cart),
                  )))
        ],
      );
    });
  }
}
