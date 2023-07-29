class Astro {
  final int id;
  final String name;
  final int price;
  final String category;
  final int temperature;
  final String image;

  Astro(
      {required this.id,
      required this.name,
      required this.price,
      required this.category,
      required this.temperature,
      required this.image});

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        category: json["category"],
        temperature: json["temperature"],
        image: json["image"]);
  }
}
