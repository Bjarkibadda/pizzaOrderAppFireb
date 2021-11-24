import 'package:flutter/material.dart';
import '../Models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.pink,
        child: FutureBuilder<Product>(
            future: IdProd(0).fetchProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 200,
                  width: double.infinity - 10,
                  child: Card(
                      shadowColor: Colors.blueAccent,
                      child: Center(child: Text(snapshot.data!.name))),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
