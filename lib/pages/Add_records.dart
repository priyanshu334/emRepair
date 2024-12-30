import 'package:em_repair/components/accessories.dart';
import 'package:em_repair/components/bar_code.dart';
import 'package:em_repair/components/bottom_nav.dart';
import 'package:em_repair/components/customer_details.dart';
import 'package:em_repair/components/date_feild.dart';
import 'package:em_repair/components/lock_code.dart';
import 'package:em_repair/components/model_details.dart';
import 'package:em_repair/components/model_feild.dart';
import 'package:em_repair/components/paid_feild.dart';
import 'package:em_repair/components/price_feild.dart';
import 'package:em_repair/components/problem_feild.dart';
import 'package:em_repair/components/reciver_feild.dart';
import 'package:em_repair/components/time_feild.dart';
import 'package:em_repair/providers/add_record_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecords extends StatefulWidget {
  const AddRecords({super.key});

  @override
  State<AddRecords> createState() => _AddRecordsState();
}

class _AddRecordsState extends State<AddRecords> {
  int _selectedIndex = 0;
  bool _isFormVisible = true; // Flag to control form visibility

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    final provider = Provider.of<AddRecordsProvider>(context, listen: false);
    provider.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddRecordsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Records",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isFormVisible) ...[ // Only show the form if _isFormVisible is true
              const Text(
                "Order Details:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: provider.selectedStatus ?? 'Pending',
                items: const [
                  DropdownMenuItem(value: 'Pending', child: Text("Pending")),
                  DropdownMenuItem(value: 'Repaired', child: Text("Repaired")),
                  DropdownMenuItem(value: 'Delivered', child: Text("Delivered")),
                  DropdownMenuItem(value: 'Canceled', child: Text("Canceled")),
                ],
                onChanged: provider.setSelectedStatus,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
              const SizedBox(height: 12),
              CustomerDetails(
                searchController: provider.searchController,
                nameController: provider.nameController,
                phoneController: provider.phoneController,
                addressController: provider.addressController,
              ),
              ModelField(textController: provider.modelController),
              ProblemField(ProblemController: provider.problemController),
              const ModelDetails(),
              PriceField(priceController: provider.priceController),
              PaidField(paidController: provider.paidController),
              const LockCode(),
              const DateFeild(),
              const TimeFeild(),
              const BarCode(),
              ReceiverField(
                operatorController: provider.operatorController,
                receiverController: provider.receiverController,
              ),
              const SizedBox(height: 12),
              const Accessories(),
              const SizedBox(height: 20),
              TextField(
                controller: provider.additionalDetailsController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Additional Details",
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "*Enter Warranty for the Mobile Solution app users.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: provider.warrantyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Device Warranty",
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Submit Button
                    ElevatedButton(
                      onPressed: provider.isLoading
                          ? null
                          : () async {
                              provider.setLoading(true);
                              await provider.saveDataToJsonFile();
                              await provider.saveToPreferences();
                              provider.setLoading(false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Record successfully saved!')),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: provider.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Submit",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                    ),
                    const SizedBox(width: 20),
                    // Cancel Button
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isFormVisible = false; // Hide the form when cancel is pressed
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Show this if the form is not visible
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isFormVisible = true; // Show the form again
                    });
                  },
                  child: const Text(
                    "Show Form Again",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
} 