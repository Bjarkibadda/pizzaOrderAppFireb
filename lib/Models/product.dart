import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../main.dart';

class IdProd {
  final int? id;
  IdProd(this.id);

  Future<Product> fetchProducts() async {
    HttpOverrides.global = MyHttpOverrides();
    final url = Uri.parse('https://localhost:5001/Product/');
    final response = await http.get(url);
    var prod = json.decode(response.body)['data'];
    Product myProd = Product.fromJson((prod));

    return myProd;
  }

  Future<Product> fetchProduct() async {
    HttpOverrides.global = MyHttpOverrides();
    final url = Uri.parse('https://localhost:5001/Product/1');
    final response = await http.get(url);
    var prod = json.decode(response.body)['data'];
    Product myProd = Product.fromJson((prod));

    return myProd;
  }
}

class Product {
  final int id;
  late String name;
  late int price;
  late String imgUrl;

  Product(this.id, this.name, this.price, this.imgUrl);
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(json['id'], json['name'], json['price'], json['imgUrl']);
  }
}
