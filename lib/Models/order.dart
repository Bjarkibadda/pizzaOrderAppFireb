import 'package:food_order_app/Models/order_item.dart';

class Order {
  final int id;
  final String name;
  final List<OrderItem> orderItems;
  final String message;
  final String address;

  Order(this.id, this.name, this.orderItems, this.message, this.address);
}
