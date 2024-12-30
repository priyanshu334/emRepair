import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatelessWidget {
  final String title;
  final CameraController controller;
  final Future<void> initializeControllerFuture;
  final Function(BuildContext) onCapture; // Callback to capture and save photo

  const CameraScreen({
    Key? key,
    required this.title,
    required this.controller,
    required this.initializeControllerFuture,
    required this.onCapture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.pink,
      ),
      body: FutureBuilder(
        future: initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onCapture(context), // Use the callback here
        child: const Icon(Icons.camera),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
