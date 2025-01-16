import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<dynamic> getPizzas() async {
    final response = await http.get(Uri.parse('$baseUrl/pizzas'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load pizzas');
    }
  }

  Future<dynamic> getPizzaById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/pizzas/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load pizza');
    }
  }

  Future<dynamic> createPizza(Map<String, dynamic> pizzaData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pizzas'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pizzaData),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create pizza');
    }
  }

  Future<dynamic> updatePizza(String id, Map<String, dynamic> pizzaData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pizzas/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pizzaData),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update pizza');
    }
  }

  Future<void> deletePizza(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pizzas/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete pizza');
    }
  }
}
