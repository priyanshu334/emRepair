import 'package:flutter/material.dart';

class PriceFeild extends StatelessWidget {
  final TextEditingController Pricecontroller;

  const PriceFeild({super.key,required this.Pricecontroller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: Pricecontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "please enter the price",
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
