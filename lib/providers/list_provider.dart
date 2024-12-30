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

  // List to hold form entries
  List<Map<String, dynamic>> entries = [];

  // Add a new entry to the list
  void addEntry() {
    final entry = {
      'name': nameController.text.trim(),
      'service': serviceController.text.trim(),
      'description': descriptionController.text.trim(),
      'isScored': false,  // Initially, the entry is not scored
    };

    entries.add(entry);
    clearFields();
    _saveData();  // Automatically save data after adding an entry
    notifyListeners();
  }

  // Toggle scored status of an entry
  void toggleScoredStatus(int index) {
    entries[index]['isScored'] = !entries[index]['isScored'];
    _saveData();  // Automatically save data after toggling the status
    notifyListeners();
  }

  // Save data to both SharedPreferences and JSON file (to avoid duplication)
  Future<void> _saveData() async {
    await saveToSharedPreferences();
    await saveToJsonFile();
  }

  // Save data to SharedPreferences
  Future<void> saveToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> encodedEntries = entries
        .map((entry) => json.encode(entry))
        .toList();

    await prefs.setStringList('operatorFormData', encodedEntries);
  }

  // Load data from SharedPreferences
  Future<void> loadFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? encodedEntries = prefs.getStringList('operatorFormData');

    if (encodedEntries != null) {
      entries = encodedEntries
          .map((entry) => json.decode(entry))
          .toList()
          .cast<Map<String, dynamic>>();

      notifyListeners();
    }
  }

  // Save data to a JSON file
  Future<void> saveToJsonFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/operator_form_data.json');

    final List<String> encodedEntries = entries
        .map((entry) => json.encode(entry))
        .toList();

    await file.writeAsString(json.encode(encodedEntries));
  }

  // Load data from a JSON file
  Future<void> loadFromJsonFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/operator_form_data.json');

      if (await file.exists()) {
        final String jsonData = await file.readAsString();
        final List<dynamic> decodedEntries = json.decode(jsonData);

        entries = decodedEntries
            .map((entry) => entry as Map<String, dynamic>)
            .toList();

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
