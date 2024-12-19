import 'package:app/providers/add_record_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/components/bar_code.dart';
import 'package:app/components/customer_details.dart';
import 'package:app/components/date_feild.dart';
import 'package:app/components/lock_code.dart';
import 'package:app/components/model_details.dart';
import 'package:app/components/model_feild.dart';
import 'package:app/components/paid_feild.dart';
import 'package:app/components/price_feild.dart';
import 'package:app/components/problem_feild.dart';
import 'package:app/components/reciver_feild.dart';
import 'package:app/components/time_feild.dart';
import 'package:app/components/bottom_nav.dart';

class AddRecords extends StatefulWidget {
  const AddRecords({super.key});

  @override
  State<AddRecords> createState() => _AddRecordsState();
}

class _AddRecordsState extends State<AddRecords> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    // Dispose of the provider controllers when the widget is removed
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
            const Text(
              "Order Details:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: provider.selectedStatus,
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
            ModelFeild(textController: provider.modelController),
            ProblemField(ProblemController: provider.problemController),
            const ModelDetails(),
            PriceFeild(Pricecontroller: provider.priceController),
            PaidFeild(Paidcontroller: provider.paidController),
            const LockCode(),
            const DateFeild(),
            const TimeFeild(),
            const BarCode(),
            ReciverFeild(
              operatorController: provider.operatorController,
              receiverController: provider.receiverController,
            ),
            const SizedBox(height: 12),
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
  child: ElevatedButton(
    onPressed: provider.isLoading
        ? null
        : () async {
            if (provider.validateControllers()) {
              provider.setLoading(true); // Set loading state to true
              await provider.saveDataToJsonFile();
              await provider.saveToPreferences();
              provider.setLoading(false); // Set loading state to false
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Record successfully saved!')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill all required fields!')),
              );
            }
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
)

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
