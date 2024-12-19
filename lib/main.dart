import 'package:app/providers/add_record_provider.dart';
import 'package:app/providers/list_provider.dart';
import 'package:app/providers/order_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/splash_screen.dart'; // Import the new splash screen file
import 'package:app/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AddRecordsProvider()),
      ChangeNotifierProvider(create: (_)=> OrderDataProvider()),
      ChangeNotifierProvider(create: (_)=>ListProvider())
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
      title: 'Em reparing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(), // Use the SplashScreen from the imported file
    );
  }
}
