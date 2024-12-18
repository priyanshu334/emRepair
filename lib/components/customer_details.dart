import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({super.key});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final TextEditingController _controller = TextEditingController();

  // Method to show the dialog for adding customer details
  void _showAddCustomerDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter Customer Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Customer Name"),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Customer Phone No"),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: "Customer Address"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without saving
              },
              child: const Text("Close"),
            ),
            TextButton(
              onPressed: () async {
                // Save customer details to SharedPreferences
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('customer_name', nameController.text);
                await prefs.setString('customer_phone', phoneController.text);
                await prefs.setString('customer_address', addressController.text);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Customer Added: ${nameController.text}')),
                );

                Navigator.pop(context); // Close the dialog after saving
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[100], // Light background color for contrast
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Customer Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Search and select from the list",
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pink.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle the "Select" button action here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Select",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: _showAddCustomerDialog, // Show the dialog on click
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
