import 'package:em_repair/providers/order_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ServiceCenterPage extends StatelessWidget {
  const ServiceCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderDataProvider = Provider.of<OrderDataProvider>(context);

    // Filter the orders with "Service Center" location
    final serviceCenterOrders = orderDataProvider.orders
        .where((order) => order['location']?.toString().toLowerCase() == 'service center')
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          "Orders at Service Center",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: orderDataProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : serviceCenterOrders.isEmpty
              ? const Center(
                  child: Text(
                    'No orders for the location "Service Center"',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: serviceCenterOrders.length,
                  itemBuilder: (context, index) {
                    final order = serviceCenterOrders[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.pink),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Customer: ${order['receiver'] ?? 'Unknown'}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Location: ${order['location'] ?? 'Not available'}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Problem: ${order['problem'] ?? 'Not available'}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Price: ${order['price'] ?? 'Not available'}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  orderDataProvider.deleteOrder(
                                      orderDataProvider.orders.indexOf(order));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text(
                                  'Remove Record',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
