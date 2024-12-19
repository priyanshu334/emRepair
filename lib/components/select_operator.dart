import 'package:app/pages/List_page.dart';
import 'package:flutter/material.dart';

class SelectOperator extends StatelessWidget {
  const SelectOperator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(
                  value: 'Operator 1',
                  child: Text('Select Operator'),
                ),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ListPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
            ),
            child: const Text(
              'List',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () async {
              // Show the date picker
              final DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), // Current date as default
                firstDate: DateTime(2000), // Earliest selectable date
                lastDate: DateTime(2100), // Latest selectable date
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Colors.pink, // Header background color
                        onPrimary: Colors.white, // Header text color
                        onSurface: Colors.black, // Body text color
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.pink, // Button text color
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (selectedDate != null) {
                // Do something with the selected date
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Selected Date: ${selectedDate.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
            ),
            child: const Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
