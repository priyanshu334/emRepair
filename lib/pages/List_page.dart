import 'package:em_repair/providers/list_provider.dart';
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
            // Form Inputs
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
                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    // Add data to list provider
                    formProvider.addEntry();
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
                // Cancel Button
                ElevatedButton(
                  onPressed: () {
                    // Clear all fields
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
            const SizedBox(height: 20),
            // Display List of Entries
            Expanded(
              child: ListView.builder(
                itemCount: formProvider.entries.length,
                itemBuilder: (context, index) {
                  final entry = formProvider.entries[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.pink),
                    ),
                    child: ListTile(
                      title: Text(entry['name']),
                      subtitle:
                          Text('${entry['service']} - ${entry['description']}'),
                      trailing: IconButton(
                        icon: Icon(
                          entry['isScored']
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: Colors.pink,
                        ),
                        onPressed: () {
                          // Toggle the 'isScored' status
                          formProvider.toggleScoredStatus(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
