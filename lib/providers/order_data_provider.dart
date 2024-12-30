import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class OrderDataProvider extends ChangeNotifier {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;

  OrderDataProvider() {
    _initializeData();
  }

  /// Initialize data by loading it from the JSON file.
  Future<void> _initializeData() async {
    await loadData();
    isLoading = false;
    notifyListeners();
  }

  /// Load data from a JSON file.
  Future<void> loadData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/orders.json');

      if (await file.exists()) {
        final String jsonData = await file.readAsString();
        if (jsonData.isNotEmpty) {
          final List<dynamic> parsedData = json.decode(jsonData);
          orders = List<Map<String, dynamic>>.from(parsedData);
        } else {
          orders = [];
        }
      } else {
        orders = [];
      }
    } catch (e) {
      debugPrint('Error loading data: $e');
      orders = [];
    }
  }

  /// Save data to a JSON file.
  Future<void> saveData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/orders.json');

      final String jsonData = json.encode(orders);
      await file.writeAsString(jsonData);
    } catch (e) {
      debugPrint('Error saving data: $e');
    }
  }

  /// Add a new order.
  void addOrder(Map<String, dynamic> order) {
    if (order.isNotEmpty) {
      orders.add(order);
      saveData();
      notifyListeners();
    } else {
      debugPrint('Cannot add an empty order.');
    }
  }

  /// Update an existing order.
  void updateOrder(int index, Map<String, dynamic> updatedOrder) {
    if (index >= 0 && index < orders.length && updatedOrder.isNotEmpty) {
      orders[index] = updatedOrder;
      saveData();
      notifyListeners();
    } else {
      debugPrint('Invalid index or empty data for updating the order.');
    }
  }

  /// Delete an order.
  void deleteOrder(int index) {
    if (index >= 0 && index < orders.length) {
      orders.removeAt(index);
      saveData();
      notifyListeners();
    } else {
      debugPrint('Invalid index for deleting the order.');
    }
  }

  /// Mark an order as completed.
  void markOrderAsCompleted(int index) {
    if (index >= 0 && index < orders.length) {
      orders[index]['status'] = 'Completed';
      saveData();
      notifyListeners();
    } else {
      debugPrint('Invalid index for marking the order as completed.');
    }
  }

  /// Reset all data.
  void resetData() {
    orders = [];
    saveData();
    notifyListeners();
  }

  /// Get orders filtered by status.
  List<Map<String, dynamic>> getOrdersByStatus(String status) {
    return orders.where((order) => order['status'] == status).toList();
  }
}
