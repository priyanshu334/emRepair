import 'package:flutter/material.dart';

class BarCode extends StatefulWidget {
  const BarCode({super.key});

  @override
  State<BarCode> createState() => _BarCodeState();
}

class _BarCodeState extends State<BarCode> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Barcode:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              // Expanded allows the TextField to take available space
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'enter or scan barcode',
                  ),
                ),
              ),
              const SizedBox(
                width: 12, // Add spacing between TextField and Button
              ),
              ElevatedButton(
                onPressed: () {
                  // Add button action
                  final text = _textController.text;
                  if (text.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Problem Added: $text')),
                    );
                    _textController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a problem')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Scan",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}