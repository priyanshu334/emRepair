import 'package:app/providers/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<ListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          "Service Operator",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: formProvider.nameController,
              decoration: const InputDecoration(
                  hintText: "Name", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: formProvider.serviceController,
              decoration: const InputDecoration(
                  hintText: "Service", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: formProvider.descriptionController,
              decoration: const InputDecoration(
                  hintText: "Description", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle form submission logic here
                    print("Name: ${formProvider.nameController.text}");
                    print("Service: ${formProvider.serviceController.text}");
                    print("Description: ${formProvider.descriptionController.text}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Clear all text fields
                    formProvider.clearFields();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
