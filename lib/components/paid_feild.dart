import 'package:flutter/material.dart';

class PaidFeild extends StatelessWidget {


  const PaidFeild({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
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
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "enter paid amount ",
            ),
          ),
          const SizedBox(height: 12,),
        ],
      ),
    );
  }
}
