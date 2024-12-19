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
                  Navigator.pop(context, 'Pending');
                },
              ),
              ListTile(
                title: const Text('Repaired'),
                onTap: () {
                  Navigator.pop(context, 'Repaired');
                },
              ),
              ListTile(
                title: const Text('Delivered'),
                onTap: () {
                  Navigator.pop(context, 'Delivered');
                },
              ),
              ListTile(
                title: const Text('Canceled'),
                onTap: () {
                  Navigator.pop(context, 'Canceled');
                },
              ),
            ],
          ),
        );
      },
    ).then((selectedValue) {
      if (selectedValue != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected Order Type: $selectedValue')),
        );
      }
    });
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
                  Navigator.pop(context, 'House');
                },
              ),
              ListTile(
                title: const Text('Service Center'),
                onTap: () {
                  Navigator.pop(context, 'Service Center');
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
                  content: Text('Today\'s Date: ${now.toLocal().toString().split(' ')[0]}'),
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
