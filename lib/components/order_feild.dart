
import 'package:em_repair/pages/canceled_page.dart';
import 'package:em_repair/pages/delivered_page.dart';
import 'package:em_repair/pages/house_page.dart';
import 'package:em_repair/pages/pending_page.dart';
import 'package:em_repair/pages/repaired_page.dart';
import 'package:flutter/material.dart';

class OrderField extends StatelessWidget {
  const OrderField({super.key});

  void _showOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Pending'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PendingPage()),
                  );
                },
              ),
              ListTile(
                title: const Text('Repaired'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RepairedPage()),
                  );
                },
              ),
              ListTile(
                title: const Text('Delivered'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DeliveredPage()),
                  );
                },
              ),
              ListTile(
                title: const Text('Canceled'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CanceledPage()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('House'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HousePage()));
                },
              ),
              ListTile(
                title: const Text('Service Center'),
                onTap: () {
                   Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HousePage()));
                
                  
                },
              ),
            ],
          ),
        );
      },
    ).then((selectedValue) {
      if (selectedValue != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected Location: $selectedValue')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () => _showOrderDialog(context),
              style: TextButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Select Order Type',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextButton(
              onPressed: () => _showLocationDialog(context),
              style: TextButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Select Location',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              final DateTime now = DateTime.now();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Today\'s Date: ${now.toLocal().toString().split(' ')[0]}'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
            ),
            child: const Text(
              'Today',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
