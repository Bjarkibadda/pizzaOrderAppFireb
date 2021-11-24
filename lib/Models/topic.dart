import 'package:food_order_app/Models/order_item.dart';

class Topic {
  final int id;
  final String name;
  final int price;
  final List<OrderItem> orderItems;

  Topic(this.id, this.name, this.price, this.orderItems);
}
