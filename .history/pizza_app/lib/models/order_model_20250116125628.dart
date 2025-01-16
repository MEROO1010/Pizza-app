class OrderModel {
  final String id;
  final String customerName;
  final String customerAddress;
  final List<String> pizzaIds;
  final DateTime orderDate;
  final double totalPrice;

  OrderModel({
    required this.id,
    required this.customerName,
    required this.customerAddress,
    required this.pizzaIds,
    required this.orderDate,
    required this.totalPrice,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      customerName: json['customerName'],
      customerAddress: json['customerAddress'],
      pizzaIds: List<String>.from(json['pizzaIds']),
      orderDate: DateTime.parse(json['orderDate']),
      totalPrice: json['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'pizzaIds': pizzaIds,
      'orderDate': orderDate.toIso8601String(),
      'totalPrice': totalPrice,
    };
  }
}
