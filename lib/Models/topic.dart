import 'package:food_order_app/Models/order_item.dart';

class Topic {
  final int id;
  final String name;
  final int price;

  Topic(this.id, this.name, this.price);

  factory Topic.fromJson(Map<dynamic, dynamic> json) {
    return Topic(json['id'], json['name'], json['price']);
  }
}
