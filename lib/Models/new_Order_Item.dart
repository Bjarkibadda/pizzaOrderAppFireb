class NewOrderItem {
  final int productId;
  final List<int> topicsId;

  NewOrderItem(this.productId, this.topicsId);

  NewOrderItem.fromJson(Map<String, dynamic> json)
      : productId = json['productId'],
        topicsId = json['topicsId'];

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'topicIds': topicsId,
      };
}
