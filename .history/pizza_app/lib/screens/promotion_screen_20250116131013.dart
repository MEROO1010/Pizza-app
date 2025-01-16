import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PromotionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Promotions')),
      body: FutureBuilder(
        future: fetchPromotions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final promotions = snapshot.data;
            return ListView.builder(
              itemCount: promotions?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(promotions?[index]['title']),
                  subtitle: Text(promotions?[index]['description']),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<dynamic>> fetchPromotions() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/promotions'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load promotions');
    }
  }
}
