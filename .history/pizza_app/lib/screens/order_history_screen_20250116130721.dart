import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<dynamic> _orderHistory = [];

  @override
  void initState() {
    super.initState();
    _fetchOrderHistory();
  }

  Future<void> _fetchOrderHistory() async {
    final response = await http.get(
      Uri.parse('http://your-nodejs-backend-url/orders'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _orderHistory = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load order history');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order History')),
      body:
          _orderHistory.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _orderHistory.length,
                itemBuilder: (context, index) {
                  final order = _orderHistory[index];
                  return ListTile(
                    title: Text('Order #${order['id']}'),
                    subtitle: Text('Total: \$${order['total']}'),
                    onTap: () {
                      // Handle order tap
                    },
                  );
                },
              ),
    );
  }
}
