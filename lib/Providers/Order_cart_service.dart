import 'package:flutter/material.dart';
import 'package:food_order_app/Models/New_Order_Item.dart';
import 'package:food_order_app/Models/menu_item.dart';
import 'package:food_order_app/Models/order_item.dart';
import 'dart:async';
import '../main.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderChartService extends ChangeNotifier {
  List<MenuItem> chartList = [];

  void addToChart(MenuItem item) {
    chartList.add(item);
    notifyListeners();
  }

  bool isCartEmpty() => chartList.isEmpty;

  Future<http.Response> makeOrder() async {
    HttpOverrides.global = MyHttpOverrides();
    // List<NewOrderItem> orderItemsList = [];
    // orderItemsList.add(NewOrderItem(1, [1]));
    var orderItemsList = getOrderItems();
    var post = await http.post(
      Uri.parse('https://localhost:5001/Order'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        'name': 'Bjarki',
        'orderItems': orderItemsList,
        'message': 'vonandi verður pizzan góð',
        'address': 'Lyngholt 18'
      }),
    );
    return post;
  }

  List<NewOrderItem> getOrderItems() {
    List<NewOrderItem> orderItemsList = [];
    for (var item in chartList) {
      orderItemsList
          .add(NewOrderItem(item.productId, item.topics.keys.toList()));
    }
    return orderItemsList;
  }
}
