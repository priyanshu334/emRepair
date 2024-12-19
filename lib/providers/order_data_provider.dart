
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class OrderDataProvider extends ChangeNotifier {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;

  OrderDataProvider() {
    loadData();
  }

  Future<void> loadData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/orders.json');

      if (await file.exists()) {
        final String jsonData = await file.readAsString();
        orders = List<Map<String, dynamic>>.from(json.decode(jsonData));
      }
    } catch (e) {
      print('Error loading data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/orders.json');

      final String jsonData = json.encode(orders);
      await file.writeAsString(jsonData);

      notifyListeners();
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  void addOrder(Map<String, dynamic> order) {
    orders.add(order);
    saveData();
  }

  void updateOrder(int index, Map<String, dynamic> updatedOrder) {
    if (index >= 0 && index < orders.length) {
      orders[index] = updatedOrder;
      saveData();
    }
  }

  void deleteOrder(int index) {
    if (index >= 0 && index < orders.length) {
      orders.removeAt(index);
      saveData();
    }
  }

  void resetData() {
    orders = [];
    saveData();
    notifyListeners();
  }
}
