import 'package:flutter/material.dart';

class PaidFeild extends StatelessWidget {
  final TextEditingController Paidcontroller;

  const PaidFeild({super.key, required this.Paidcontroller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Paid:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: Paidcontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "enter paid amount ",
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
