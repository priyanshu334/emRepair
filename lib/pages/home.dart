// lib/pages/home_page.dart
import 'package:em_repair/pages/selected_customer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:em_repair/components/order_feild.dart';
import 'package:em_repair/components/select_operator.dart';
import 'package:em_repair/pages/Add_records.dart';
import 'package:em_repair/providers/order_data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController receiverController = TextEditingController();
  final List<String> selectedCustomers = [];

  void clearSelectedCustomers() {
    setState(() {
      selectedCustomers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderDataProvider = Provider.of<OrderDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          'ALL RECORDS',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectedCustomersPage(
                    selectedCustomers: selectedCustomers,
                    clearSelectedCustomers: clearSelectedCustomers,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.list_alt, color: Colors.white),
          ),
        ],
      ),
      body: orderDataProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: receiverController,
                          decoration: InputDecoration(
                            hintText: 'Search Customer Name',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              bool isSelected = false;
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Search Results',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Receiver: ${receiverController.text.isNotEmpty ? receiverController.text : 'No value entered'}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: isSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  isSelected = value!;
                                                });
                                              },
                                            ),
                                            const Text('Select this customer'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (isSelected &&
                                              receiverController.text.isNotEmpty) {
                                            selectedCustomers.add(
                                                receiverController.text.trim());
                                          }
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(color: Colors.pink),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                        ),
                        child: const Text(
                          'Search',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SelectOperator(),
                const OrderField(),
                const SizedBox(height: 8),
                Expanded(
                  child: orderDataProvider.orders.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/ep.png',
                                height: 150,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'No records found',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: orderDataProvider.orders.length,
                          itemBuilder: (context, index) {
                            final record = orderDataProvider.orders[index];
                            final String? imagePath = record['modelDetails']['imagePath'];

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
                                      // Display image if available
                                      imagePath != null && imagePath.isNotEmpty
                                          ? Image.file(
                                              File(imagePath),
                                              height: 200,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            )
                                          : const SizedBox.shrink(),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Status: ${record['modelDetails']['status'] ?? 'Not available'}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Model: ${record['modelDetails']['model'] ?? 'Not available'}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Customer Name: ${record['modelDetails']['receiver'] ?? 'Not available'}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Repair Type: ${record['modelDetails']['problem'] ?? 'Not available'}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Date: ${record['dateTime'] ?? 'Not available'}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRecords()),
          );
        },
        backgroundColor: Colors.pink,
        child: const Icon(
          Icons.list,
          color: Colors.white,
        ),
      ),
    );
  }
}
