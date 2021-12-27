class MenuItem {
  late String description;
  late String product;
  late List<String> topics;
  late int price;
  late String imageUrl;

  MenuItem(
      this.description, this.product, this.topics, this.price, this.imageUrl);
  factory MenuItem.fromJson(Map<dynamic, dynamic> json) {
    return MenuItem(json['description'], json['product'],
        json['topics'].cast<String>(), json['price'], json['imageUrl']);
  }
}
