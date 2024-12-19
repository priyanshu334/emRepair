import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRecordsProvider with ChangeNotifier {
  String? selectedStatus;
  final TextEditingController additionalDetailsController = TextEditingController();
  final TextEditingController warrantyController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController problemController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController paidController = TextEditingController();
  final TextEditingController operatorController = TextEditingController();
  final TextEditingController receiverController = TextEditingController();
 final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
    bool isLoading = false;

  

  // Load data from JSON file
  Future<void> loadDataFromJsonFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/orders.json');

      if (await file.exists()) {
        final String jsonData = await file.readAsString();
        final List<Map<String, dynamic>> orders = List<Map<String, dynamic>>.from(json.decode(jsonData));

        if (orders.isNotEmpty) {
          final Map<String, dynamic> data = orders.last;

          // Populate controllers and selected status
          selectedStatus = data['status'];
          modelController.text = data['model'] ?? '';
          problemController.text = data['problem'] ?? '';
          priceController.text = data['price'] ?? '';
          paidController.text = data['paid'] ?? '';
          additionalDetailsController.text = data['additionalDetails'] ?? '';
          warrantyController.text = data['warranty'] ?? '';
          operatorController.text = data['operator'] ?? '';
          receiverController.text = data['receiver'] ?? '';
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading JSON file: $e');
    }
  }

  // Save data to JSON file
  Future<void> saveDataToJsonFile() async {
    final Map<String, dynamic> formData = {
      'status': selectedStatus,
      'model': modelController.text,
      'problem': problemController.text,
      'price': priceController.text,
      'paid': paidController.text,
      'additionalDetails': additionalDetailsController.text,
      'warranty': warrantyController.text,
      'operator': operatorController.text,
      'receiver': receiverController.text,
    };

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/orders.json');

      List<Map<String, dynamic>> orders = [];

      // If the file exists, load existing data
      if (await file.exists()) {
        final String jsonData = await file.readAsString();
        orders = List<Map<String, dynamic>>.from(json.decode(jsonData));
      }

      // Add the new record to the list
      orders.add(formData);

      // Save the updated list back to the file
      final String updatedJsonData = json.encode(orders);
      await file.writeAsString(updatedJsonData);

      notifyListeners();
    } catch (e) {
      debugPrint('Error saving JSON file: $e');
    }
  }

  // Save form data using SharedPreferences
  Future<void> saveToPreferences() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('status', selectedStatus ?? '');
      prefs.setString('model', modelController.text);
      prefs.setString('problem', problemController.text);
      prefs.setString('price', priceController.text);
      prefs.setString('paid', paidController.text);
      prefs.setString('additionalDetails', additionalDetailsController.text);
      prefs.setString('warranty', warrantyController.text);
      prefs.setString('operator', operatorController.text);
      prefs.setString('receiver', receiverController.text);

      notifyListeners();
    } catch (e) {
      debugPrint('Error saving to SharedPreferences: $e');
    }
  }

  // Load form data from SharedPreferences
  Future<void> loadFromPreferences() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      selectedStatus = prefs.getString('status');
      modelController.text = prefs.getString('model') ?? '';
      problemController.text = prefs.getString('problem') ?? '';
      priceController.text = prefs.getString('price') ?? '';
      paidController.text = prefs.getString('paid') ?? '';
      additionalDetailsController.text = prefs.getString('additionalDetails') ?? '';
      warrantyController.text = prefs.getString('warranty') ?? '';
      operatorController.text = prefs.getString('operator') ?? '';
      receiverController.text = prefs.getString('receiver') ?? '';

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading from SharedPreferences: $e');
    }
  }
   void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }
  // Validate form fields
  bool validateControllers() {
    return selectedStatus != null &&
        modelController.text.isNotEmpty &&
        problemController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        paidController.text.isNotEmpty;
  }

  void setSelectedStatus(String? status) {
    selectedStatus = status;
    notifyListeners();
  }

  // Dispose controllers to free resources
  void disposeControllers() {
    additionalDetailsController.dispose();
    warrantyController.dispose();
    modelController.dispose();
    problemController.dispose();
    priceController.dispose();
    paidController.dispose();
    operatorController.dispose();
    receiverController.dispose();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }
}
