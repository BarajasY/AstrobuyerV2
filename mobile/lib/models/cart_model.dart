class CartAstro {
  final int id;
  final String name;
  final int price;
  final String category;
  final int temperature;
  final String image;
  final int itemId;

  CartAstro(
      {required this.id,
      required this.name,
      required this.price,
      required this.category,
      required this.temperature,
      required this.image,
      required this.itemId});

  factory CartAstro.fromJson(Map<String, dynamic> json) {
    return CartAstro(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        category: json["category"],
        temperature: json["temperature"],
        image: json["image"],
        itemId: json["item_id"]);
  }
}
