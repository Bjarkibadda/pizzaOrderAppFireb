class MenuDish {
  late int id;
  late String description;
  late int productId;
  late String productName;
  late Map<String, String> topics;
  late int price12;
  late int price16;
  late String imageUrl;
  int count12 = 1;
  int count16 = 1;
  bool isBig = true;

  MenuDish(this.id, this.description, this.productId, this.productName,
      this.topics, this.price12, this.price16, this.imageUrl);
  factory MenuDish.fromJson(Map<dynamic, dynamic> json) {
    return MenuDish(
        json['id'],
        json['description'],
        json['productId'],
        json['productName'],
        json['topics'].cast<String, String>(),
        json['price12'],
        json['price16'],
        json['imageUrl']);
  }
}
