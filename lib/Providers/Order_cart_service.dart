import 'package:flutter/material.dart';
import 'package:food_order_app/Models/New_Order_Item.dart';
import 'package:food_order_app/Models/menu_item.dart';
import 'package:food_order_app/Models/topic.dart';
import 'dart:async';
import '../main.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderChartService extends ChangeNotifier {
  List<MenuDish> menuList = [];
  List<NewOrderItem> customList =
      []; // contains elements of custome made pizzas

  void addToChart(MenuDish item) {
    var exist = false;
    for (var i in menuList) {
      if (i.id == item.id && i.isBig == item.isBig) {
        i.isBig ? item.count16 += 1 : item.count12 += 1;
        exist = true;
      }
    }
    if (!exist) menuList.add(item);
    notifyListeners();
  }

  void addCustomToChart(List<int> item) {
    customList.add(NewOrderItem(0, item));
    notifyListeners();
  }

  bool isCartEmpty() => menuList.isEmpty;

  Future<http.Response> makeOrder() async {
    HttpOverrides.global = MyHttpOverrides();
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
    orderItemsList.addAll(customList);

    for (var item in menuList) {
      List<int> topicIds = [];
      for (var topic in item.topics.keys) {
        topicIds.add(int.parse(topic));
      }
      orderItemsList.add(NewOrderItem(item.productId, topicIds));
    }

    // for(var item in customList){
    //   List<int> topicIds = [];
    //   for (var topicId in item.topicsId){
    //     topicIds.add(int.parse(topicId)) // mögulega nota tryparse hér og höndla ef villa.
    //   }
    // }
    return orderItemsList;
  }

  void deleteFromOrder(MenuDish item) {
    item.count16 = 1;
    menuList.remove(item);
    notifyListeners();
  }

  void lowerCount(MenuDish item) {
    if (item.count16 < 2) return;
    item.count16 -= 1;
    notifyListeners();
  }

  void addToCount(MenuDish item) {
    item.count16 += 1;
    notifyListeners();
  }

  int itemCount() {
    var count = 0;
    for (var item in menuList) {
      count += item.count16;
    }
    return count;
  }

  int totalPrice() {
    var totalPrice = 0;
    for (var item in menuList) {
      totalPrice += item.price12;
    }
    return totalPrice;
  }

  void changeSize(MenuDish item, bool big) {
    if (big == true) {
      item.isBig = true;
    } else {
      item.isBig = false;
    }
  }
}
