import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Pizzas')),
      body: Center(child: Text('Your favorite pizzas will be displayed here.')),
    );
  }
}
