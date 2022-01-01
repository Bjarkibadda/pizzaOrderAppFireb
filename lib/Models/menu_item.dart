class MenuItem {
  late String description;
  late int productId;
  late String productName;
  late Map<int, String> topics;
  late int price;
  late String imageUrl;

  MenuItem(this.description, this.productId, this.productName, this.topics,
      this.price, this.imageUrl);
  factory MenuItem.fromJson(Map<dynamic, dynamic> json) {
    return MenuItem(json['description'], json['productId'], json['productName'],
        json['topics'].cast<int, String>(), json['price'], json['imageUrl']);
  }
}

// class MenuItem {
//   late String description;
//   late String product;
//   late Map<nt,String > topics;
//   late int price;
//   late String imageUrl;

//   MenuItem(
//       this.description, this.product, this.topics, this.price, this.imageUrl);
//   factory MenuItem.fromJson(Map<dynamic, dynamic> json) {
//     return MenuItem(json['description'], json['product'],
//         json['topics'].cast<String>(), json['price'], json['imageUrl']);
//   }
// }
