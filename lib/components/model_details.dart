import 'dart:io';

import 'package:em_repair/components/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class ModelDetails extends StatefulWidget {
  const ModelDetails({super.key});

  @override
  _ModelDetailsState createState() => _ModelDetailsState();
}

class _ModelDetailsState extends State<ModelDetails> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> cameras;
  bool _isAgreed = false; // Tracks whether the checkbox is checked
  String? frontImagePath; // Store the front device image path
  String? backImagePath;  // Store the back device image path
  String? barcodeImagePath; // Store the barcode image path

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

  // Capture image and save to file storage
  Future<void> _captureAndSavePhoto(BuildContext context, String imageType) async {
    try {
      await _initializeControllerFuture;

      // Capture the photo
      final XFile file = await _controller.takePicture();

      // Get the application directory
      final directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/${DateTime.now().toIso8601String()}.jpg';

      // Save the file
      final File savedFile = File(filePath);
      await savedFile.writeAsBytes(await file.readAsBytes());

      setState(() {
        // Update the corresponding image path based on imageType
        if (imageType == 'Device Front') {
          frontImagePath = filePath;
        } else if (imageType == 'Device Back') {
          backImagePath = filePath;
        } else if (imageType == 'Barcode') {
          barcodeImagePath = filePath;
        }
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image saved to $filePath")),
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
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _showModelDetailsDialog(context),
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
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: [
                    _buildIcon(Icons.camera_front, "Device Front", frontImagePath, () {
                      _navigateToCameraScreen(context, "Device Front");
                    }),
                    _buildIcon(Icons.photo_camera_back, "Device Back", backImagePath, () {
                      _navigateToCameraScreen(context, "Device Back");
                    }),
                    _buildIcon(Icons.barcode_reader, "Barcode", barcodeImagePath, () {
                      _navigateToCameraScreen(context, "Barcode");
                    }),
                    _buildIcon(Icons.note, "Note", null, () {
                      _showTermsAndConditionsDialog(context);
                    }),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Use imagePaths here for further actions
                        if (frontImagePath != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Front image path: $frontImagePath")),
                          );
                        }
                        if (backImagePath != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Back image path: $backImagePath")),
                          );
                        }
                        if (barcodeImagePath != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Barcode image path: $barcodeImagePath")),
                          );
                        }
                        Navigator.pop(context);
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

  // Navigate to the camera screen
  void _navigateToCameraScreen(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(
          title: title,
          controller: _controller,
          initializeControllerFuture: _initializeControllerFuture,
          onCapture: (BuildContext context) => _captureAndSavePhoto(context, title), // Pass callback to capture photo
        ),
      ),
    );
  }

  // Function to show the Terms and Conditions dialog
  void _showTermsAndConditionsDialog(BuildContext context) {
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
                  "Terms and Conditions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Please read and agree to the terms and conditions before proceeding.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _isAgreed,
                      onChanged: (value) {
                        setState(() {
                          _isAgreed = value!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text("I agree to the terms and conditions."),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: _isAgreed
                          ? () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Terms accepted!"),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                      child: const Text("Done"),
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
  Widget _buildIcon(IconData icon, String label, String? imagePath, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: imagePath == null || imagePath.isEmpty
              ? Icon(icon, size: 36, color: Colors.pink)
              : Image.file(File(imagePath), width: 50, height: 50, fit: BoxFit.cover),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
