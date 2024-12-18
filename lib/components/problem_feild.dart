import 'package:flutter/material.dart';

class ProblemField extends StatefulWidget {
  final TextEditingController ProblemController;
  const ProblemField({super.key,required this.ProblemController});

  @override
  State<ProblemField> createState() => _ProblemFieldState();
}

class _ProblemFieldState extends State<ProblemField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Write Problems",
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
                  controller:widget.ProblemController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Describe problem',
                  ),
                ),
              ),
              const SizedBox(
                width: 12, // Add spacing between TextField and Button
              ),
              ElevatedButton(
                onPressed: () {
                  // Add button action
                  final text = widget.ProblemController.text;
                  if (text.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Problem Added: $text')),
                    );
                    widget.ProblemController.clear();
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
                  "Add",
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
