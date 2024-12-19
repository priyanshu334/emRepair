import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class ListProvider with ChangeNotifier {
  // TextEditingControllers for different text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Save data to SharedPreferences
  Future<void> saveToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map<String, String> data = {
      'name': nameController.text,
      'service': serviceController.text,
      'description': descriptionController.text,
    };

    await prefs.setString('operatorFormData', json.encode(data));
    notifyListeners();
  }

  // Load data from SharedPreferences
  Future<void> loadFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonData = prefs.getString('operatorFormData');

    if (jsonData != null) {
      final Map<String, dynamic> data = json.decode(jsonData);

      nameController.text = data['name'] ?? '';
      serviceController.text = data['service'] ?? '';
      descriptionController.text = data['description'] ?? '';
      notifyListeners();
    }
  }

  // Save data to a JSON file
  Future<void> saveToJsonFile() async {
    final Map<String, String> data = {
      'name': nameController.text,
      'service': serviceController.text,
      'description': descriptionController.text,
    };

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/operator_form_data.json');

    await file.writeAsString(json.encode(data));
    notifyListeners();
  }

  // Load data from a JSON file
  Future<void> loadFromJsonFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/operator_form_data.json');

      if (await file.exists()) {
        final String jsonData = await file.readAsString();
        final Map<String, dynamic> data = json.decode(jsonData);

        nameController.text = data['name'] ?? '';
        serviceController.text = data['service'] ?? '';
        descriptionController.text = data['description'] ?? '';
        notifyListeners();
      }
    } catch (e) {
      print('Error loading data from JSON file: $e');
    }
  }

  // Clear all text fields
  void clearFields() {
    nameController.clear();
    serviceController.clear();
    descriptionController.clear();
    notifyListeners();
  }

  // Dispose controllers when not needed
  void disposeControllers() {
    nameController.dispose();
    serviceController.dispose();
    descriptionController.dispose();
  }
}
