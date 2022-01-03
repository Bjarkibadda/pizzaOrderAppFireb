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
    var exist = false;
    for (var i in chartList) {
      if (i.id == item.id) {
        i.count += 1;
        exist = true;
      }
    }
    if (!exist) chartList.add(item);
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
    List<int> topicIds = [];
    for (var item in chartList) {
      for (var topic in item.topics.keys) {
        topicIds.add(int.parse(topic));
      }
      orderItemsList.add(NewOrderItem(item.productId, topicIds));
    }
    return orderItemsList;
  }

  void deleteFromOrder(MenuItem item) {
    item.count = 1;
    chartList.remove(item);
    notifyListeners();
  }

  void lowerCount(MenuItem item) {
    if (item.count < 2) return;
    item.count -= 1;
    notifyListeners();
  }

  void addToCount(MenuItem item) {
    item.count += 1;
    notifyListeners();
  }

  int itemCount() {
    var count = 0;
    for (var item in chartList) {
      count += item.count;
    }
    return count;
  }
}
