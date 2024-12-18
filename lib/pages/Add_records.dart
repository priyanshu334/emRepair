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
import 'package:flutter/material.dart';

class AddRecords extends StatefulWidget {
  const AddRecords({super.key});

  @override
  State<AddRecords> createState() => _AddRecordsState();
}

class _AddRecordsState extends State<AddRecords> {
  int _selectedIndex = 0;
  final TextEditingController additionalDetailsController = TextEditingController();
  final TextEditingController warrantyController = TextEditingController();
  String? _selectedStatus;

  // Handle bottom navigation bar taps
  void onsubmit(){
    
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add logic to handle each tab (Phone, Message, WhatsApp, Printout)
    if (index == 0) {
      // Handle Phone logic
    } else if (index == 1) {
      // Handle Message logic
    } else if (index == 2) {
      // Handle WhatsApp logic
    } else if (index == 3) {
      // Handle Printout logic
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Records",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Order Details:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  items: const [
                    DropdownMenuItem(value: 'Pending', child: Text("Pending")),
                    DropdownMenuItem(value: 'Repaired', child: Text("Repaired")),
                    DropdownMenuItem(value: 'Delivered', child: Text("Delivered")),
                    DropdownMenuItem(value: 'Canceled', child: Text("Canceled")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
                const SizedBox(height: 12),
                const CustomerDetails(),
                const ModelFeild(),
                const ProblemField(),
                const ModelDetails(),
                const PriceFeild(),
                const PaidFeild(),
                const LockCode(),
                const DateFeild(),
                const TimeFeild(),
                const BarCode(),
                const ReciverFeild(),
                const SizedBox(height: 12),
                TextField(
                  controller: additionalDetailsController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Additional Details",
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "*Enter Warranty. This will show to users if they are users of the Mobile Solution Application and use the same number or alternate number for their account. They can see order status, details, and order images.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: warrantyController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Device Warranty",
                  ),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(onPressed: onsubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15)
                  ),
                  
                   child: Text("Submit",style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold),)),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
