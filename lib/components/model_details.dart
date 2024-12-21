import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ModelDetails extends StatefulWidget {
  const ModelDetails({super.key});

  @override
  _ModelDetailsState createState() => _ModelDetailsState();
}

class _ModelDetailsState extends State<ModelDetails> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Initialize the camera
  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  // Capture image
  Future<void> _capturePhoto() async {
    try {
      // Wait for the camera to initialize
      await _initializeControllerFuture;

      // Take the picture
      final XFile file = await _controller.takePicture();

      // You can do something with the captured image, such as displaying it
      // In this case, we're just printing the path for now
      print("Captured image: ${file.path}");

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Image captured!")),
      );
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
                      _capturePhoto(); // Open camera and capture image
                    }),
                    _buildIcon(Icons.photo_camera_back, "Device Back", () {
                      _capturePhoto(); // Open camera and capture image
                    }),
                    _buildIcon(Icons.barcode_reader, "Barcode", () {
                      _capturePhoto(); // Open camera and capture image
                    }),
                    _buildIcon(Icons.note, "Note", () {
                      _capturePhoto(); // Open camera and capture image
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
