import 'package:em_repair/pages/splash_screen.dart';
import 'package:em_repair/providers/add_record_provider.dart';
import 'package:em_repair/providers/list_provider.dart';
import 'package:em_repair/providers/order_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // Import the camera package
 // Import the splash screen file
import 'package:provider/provider.dart';

List<CameraDescription>? cameras; // List to hold available cameras

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for asynchronous initialization
  try {
    cameras = await availableCameras(); // Fetch available cameras
  } catch (e) {
    debugPrint('Error initializing cameras: $e');
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AddRecordsProvider()),
      ChangeNotifierProvider(create: (_) => OrderDataProvider()),
      ChangeNotifierProvider(create: (_) => ListProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EM Repairing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(), // Start with the splash screen
    );
  }
}
