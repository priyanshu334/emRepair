import 'package:flutter/material.dart';

class ReciverFeild extends StatefulWidget {
  final TextEditingController receiverController;
  final TextEditingController operatorController;
  const ReciverFeild({super.key,required this.operatorController,required this.receiverController});

  @override
  State<ReciverFeild> createState() => _ReciverFeildState();
}

class _ReciverFeildState extends State<ReciverFeild> {
  bool _inHouse = false;
  bool _serviceCenter = false;

  // Function to handle checkbox state change
  void _onChanged(bool? value, String type) {
    setState(() {
      if (type == 'inHouse') {
        _inHouse = value ?? false;
      } else if (type == 'serviceCenter') {
        _serviceCenter = value ?? false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          color: Colors.grey[200], // Added color to avoid error
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: widget.receiverController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Name of Receiver (Owner/Assistant)",
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Select Operator",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: widget.operatorController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Select operator",
                ),
              ),
              const SizedBox(height: 10),
              const Text("Other Locations:"),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: _inHouse,
                    onChanged: (value) => _onChanged(value, 'inHouse'),
                  ),
                  const Text("In-house"),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _serviceCenter,
                    onChanged: (value) => _onChanged(value, 'serviceCenter'),
                  ),
                  const Text("Service Center"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
