import 'package:flutter/material.dart';

class ModelDetails extends StatelessWidget {
  const ModelDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: double.infinity, // Makes the button take the full width
        child: ElevatedButton(
          onPressed: () => _showModelDetailsDialog(context), // Call the function
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
          ),
          child: const Text(
            "Model Details",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // Function to handle the dialog box logic
  void _showModelDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Model Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Grid of different icons
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: [
                    _buildIcon(Icons.camera_front, "Device Front", () {
                      // Handle Car action
                      print("Car selected");
                    }),
                    _buildIcon(Icons.photo_camera_back, "Device back", () {
                      // Handle Phone action
                      print("Phone selected");
                    }),
                    
                    _buildIcon(Icons.barcode_reader, "Barcode", () {
                      // Handle Headphones action
                      print("Headphones selected");
                    }),
                    _buildIcon(Icons.note_add, "Notes", () {
                      // Handle Watch action
                      print("Watch selected");
                    }),
                  ],
                ),
                const SizedBox(height: 16),
                // Two buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle "Cancel" button action
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle "Confirm" button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                      child: const Text("Confirm"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper function to build an icon with a label and action
  Widget _buildIcon(IconData icon, String label, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, size: 36, color: Colors.pink),
          onPressed: onTap,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
