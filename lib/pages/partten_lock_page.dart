import 'package:flutter/material.dart';

class PatternLockPage extends StatefulWidget {
  const PatternLockPage({super.key});

  @override
  State<PatternLockPage> createState() => _PatternLockPageState();
}

class _PatternLockPageState extends State<PatternLockPage> {
  List<int> _pattern = []; // To store the pattern entered by the user

  // Function to handle the user's pattern input
  void _addToPattern(int index) {
    if (!_pattern.contains(index)) {
      setState(() {
        _pattern.add(index);
      });
    }
  }

  // Function to reset the pattern
  void _resetPattern() {
    setState(() {
      _pattern.clear();
    });
  }

  // Function to save the pattern lock code (for simplicity, just saving as a string of indices)
  Future<void> _savePatternLockCode() async {
    String patternCode = _pattern.join(','); // Convert pattern to a string
    // You can save this string using SharedPreferences or a database here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pattern saved: $patternCode')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pattern Lock'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _savePatternLockCode,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Make the grid scrollable
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _addToPattern(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _pattern.contains(index)
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 40, // Smaller size for the boxes
                      width: 40,  // Smaller size for the boxes
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetPattern,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Reset Pattern'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
