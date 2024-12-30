import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:em_repair/providers/order_data_provider.dart';

class CanceledPage extends StatelessWidget {
  const CanceledPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderDataProvider = Provider.of<OrderDataProvider>(context);

    final canceledOrders = orderDataProvider.orders
        .where((order) =>
            order['status']?.toString().toLowerCase() == 'canceled')
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          "Customers with Canceled Status",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: orderDataProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : canceledOrders.isEmpty
              ? const Center(
                  child: Text(
                    'No customers with canceled status',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: canceledOrders.length,
                  itemBuilder: (context, index) {
                    final order = canceledOrders[index];
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
                                'Model: ${order['model'] ?? 'Not available'}',
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
