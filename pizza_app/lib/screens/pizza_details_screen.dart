import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PizzaDetailsScreen extends StatefulWidget {
  final int pizzaId;

  PizzaDetailsScreen({required this.pizzaId});

  @override
  _PizzaDetailsScreenState createState() => _PizzaDetailsScreenState();
}

class _PizzaDetailsScreenState extends State<PizzaDetailsScreen> {
  late Map<String, dynamic> pizzaDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPizzaDetails();
  }

  Future<void> fetchPizzaDetails() async {
    final response = await http.get(
      Uri.parse('http://your-nodejs-backend-url/pizzas/${widget.pizzaId}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        pizzaDetails = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load pizza details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pizza Details')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pizzaDetails['name'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Ingredients: ${pizzaDetails['ingredients'].join(', ')}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Price: \$${pizzaDetails['price']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
    );
  }
}
