class Pizza {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> toppings;

  Pizza({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.toppings,
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      toppings: List<String>.from(json['toppings']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'toppings': toppings,
    };
  }
}
