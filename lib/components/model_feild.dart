import 'package:flutter/material.dart';

class ModelFeild extends StatefulWidget {
  final TextEditingController textController;
  const ModelFeild({super.key,required this.textController});
  @override
  State<ModelFeild> createState() => _ModelFeildState();
}

class _ModelFeildState extends State<ModelFeild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(9),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Model",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: widget.textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Model..',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
