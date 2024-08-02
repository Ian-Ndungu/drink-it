class Drink {
  final int id;
  final String name;
  // ignore: non_constant_identifier_names
  final String image_url;
  final double price;

  // ignore: non_constant_identifier_names
  Drink({required this.id,required this.name, required this.image_url, required this.price});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      id: json['id'],
      name: json['name'],
      image_url: json['image_url'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
