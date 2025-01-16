import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderTrackingScreen extends StatefulWidget {
  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  bool _isLoading = true;
  late Map<String, dynamic> _orderData;

  @override
  void initState() {
    super.initState();
    _fetchOrderData();
  }

  Future<void> _fetchOrderData() async {
    final response = await http.get(
      Uri.parse('http://your-nodejs-backend-url.com/order-status'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _orderData = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Tracking')),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _orderData != null
              ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ID: ${_orderData['orderId']}'),
                    SizedBox(height: 8),
                    Text('Status: ${_orderData['status']}'),
                    SizedBox(height: 8),
                    Text(
                      'Estimated Delivery: ${_orderData['estimatedDelivery']}',
                    ),
                  ],
                ),
              )
              : Center(child: Text('Failed to load order data')),
    );
  }
}
