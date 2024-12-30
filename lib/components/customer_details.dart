import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerDetails extends StatefulWidget {
  final TextEditingController searchController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;

  const CustomerDetails({
    super.key,
    required this.searchController,
    required this.nameController,
    required this.phoneController,
    required this.addressController,
  });

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final _formKey = GlobalKey<FormState>(); // Key for the form
  List<Map<String, String>> _customers = [];

  // Load customers from SharedPreferences
  Future<void> _loadCustomers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? storedCustomers = prefs.getStringList('customers');
    if (storedCustomers != null) {
      setState(() {
        _customers = storedCustomers
            .map((customer) => Map<String, String>.from(
                  customer.replaceAll("{", "").replaceAll("}", "").split(", ").fold(
                        {},
                        (map, element) {
                          final kv = element.split(": ");
                          return {...map, kv[0]: kv[1]};
                        },
                      ),
                ))
            .toList();
      });
    }
  }

  // Save customers to SharedPreferences
  Future<void> _saveCustomers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('customers', _customers.map((c) => c.toString()).toList());
  }

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  void _showAddCustomerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter Customer Details"),
          content: Form(
            key: _formKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: widget.nameController,
                    decoration: const InputDecoration(labelText: "Customer Name"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: widget.phoneController,
                    decoration: const InputDecoration(labelText: "Customer Phone No"),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Phone number is required';
                      }
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return 'Enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: widget.addressController,
                    decoration: const InputDecoration(labelText: "Customer Address"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  setState(() {
                    _customers.add({
                      'name': widget.nameController.text,
                      'phone': widget.phoneController.text,
                      'address': widget.addressController.text,
                    });
                  });

                  await _saveCustomers();

                  widget.nameController.clear();
                  widget.phoneController.clear();
                  widget.addressController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Customer Added')),
                  );

                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _showSelectCustomerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select a Customer"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              itemCount: _customers.length,
              itemBuilder: (context, index) {
                final customer = _customers[index];
                return ListTile(
                  title: Text(customer['name'] ?? 'No Name'),
                  subtitle: Text("Phone: ${customer['phone']}\nAddress: ${customer['address']}"),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.pop(context, customer);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    ).then((selectedCustomer) {
      if (selectedCustomer != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selected Customer: ${selectedCustomer['name']}")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[100],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: widget.searchController,
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
                      onPressed: _showSelectCustomerDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
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
                      onPressed: _showAddCustomerDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
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
            ),
          ),
        ],
      ),
    );
  }
}
