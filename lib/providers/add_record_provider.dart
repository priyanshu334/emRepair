import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRecordsProvider with ChangeNotifier {
  String? selectedStatus = 'Pending'; // Set default status
  DateTime? dateTime = DateTime.now(); // Initialize to current date

  // Controllers
  final Map<String, TextEditingController> _controllers = {
    'additionalDetails': TextEditingController(),
    'warranty': TextEditingController(),
    'model': TextEditingController(),
    'problem': TextEditingController(),
    'price': TextEditingController(),
    'paid': TextEditingController(),
    'operator': TextEditingController(),
    'receiver': TextEditingController(),
    'search': TextEditingController(),
    'name': TextEditingController(),
    'phone': TextEditingController(),
    'address': TextEditingController(),
  };

  List<Map<String, dynamic>> _records = []; // List to store all records
  List<Map<String, dynamic>> get records => _records;

  bool isLoading = false;

  // Controller Getters
  TextEditingController get searchController => _controllers['search']!;
  TextEditingController get nameController => _controllers['name']!;
  TextEditingController get phoneController => _controllers['phone']!;
  TextEditingController get addressController => _controllers['address']!;
  TextEditingController get modelController => _controllers['model']!;
  TextEditingController get problemController => _controllers['problem']!;
  TextEditingController get priceController => _controllers['price']!;
  TextEditingController get paidController => _controllers['paid']!;
  TextEditingController get operatorController => _controllers['operator']!;
  TextEditingController get receiverController => _controllers['receiver']!;
  TextEditingController get additionalDetailsController => _controllers['additionalDetails']!;
  TextEditingController get warrantyController => _controllers['warranty']!;

  // Load data from JSON file
  Future<void> loadDataFromJsonFile() async {
    try {
      final file = await _getJsonFile();
      if (await file.exists()) {
        final String jsonData = await file.readAsString();
        _records = List<Map<String, dynamic>>.from(json.decode(jsonData));
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading JSON file: $e');
    }
  }

  // Save data to JSON file
  Future<void> saveDataToJsonFile({String? capturedImagePath}) async {
    try {
      final Map<String, dynamic> formData = {
        'dateTime': DateTime.now().toIso8601String(),
        'modelDetails': {
          'status': selectedStatus,
          'model': _controllers['model']!.text,
          'problem': _controllers['problem']!.text,
          'price': _controllers['price']!.text,
          'paid': _controllers['paid']!.text,
          'additionalDetails': _controllers['additionalDetails']!.text,
          'warranty': _controllers['warranty']!.text,
          'operator': _controllers['operator']!.text,
          'receiver': _controllers['receiver']!.text,
          'imagePath': capturedImagePath ?? '',
        },
      };

      _records.add(formData);
      final file = await _getJsonFile();
      await file.writeAsString(json.encode(_records));
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving JSON file: $e');
    }
  }

  // Remove a record by index
  void removeRecord(int index) {
    if (index >= 0 && index < _records.length) {
      _records.removeAt(index);
      notifyListeners();
      _saveRecordsToFile(); // Save updated list to file
    }
  }

  Future<void> _saveRecordsToFile() async {
    try {
      final file = await _getJsonFile();
      await file.writeAsString(json.encode(_records));
    } catch (e) {
      debugPrint('Error saving JSON file: $e');
    }
  }

  // Populate controllers with loaded data
  void _populateControllers(Map<String, dynamic> modelDetails) {
    modelDetails.forEach((key, value) {
      if (_controllers.containsKey(key)) {
        _controllers[key]!.text = value ?? '';
      }
    });
  }

  // Helper to get the JSON file
  Future<File> _getJsonFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/orders.json');
  }

  // Save form data using SharedPreferences
  Future<void> saveToPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      prefs.setString('status', selectedStatus ?? '');
      for (var entry in _controllers.entries) {
        prefs.setString(entry.key, entry.value.text);
      }
    } catch (e) {
      debugPrint('Error saving to SharedPreferences: $e');
    }
  }

  // Validate form fields
  bool validateControllers() {
    return selectedStatus != null &&
        selectedStatus!.isNotEmpty &&
        _controllers['model']!.text.isNotEmpty &&
        _controllers['problem']!.text.isNotEmpty &&
        _controllers['price']!.text.isNotEmpty &&
        _controllers['paid']!.text.isNotEmpty &&
        _controllers['receiver']!.text.isNotEmpty;
  }

  void setSelectedStatus(String? status) {
    selectedStatus = status;
    notifyListeners();
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  // Dispose controllers to free resources
  void disposeControllers() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }
}
