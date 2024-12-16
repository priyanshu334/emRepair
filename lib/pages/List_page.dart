import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              controller: _controller,
              decoration:const  InputDecoration(
                  hintText: "Name", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _controller,
              decoration:const  InputDecoration(
                  hintText: "Name", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _controller,
              decoration:const InputDecoration(
                  hintText: "Name", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink  ,
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                ),child: Text("Submit ",style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),)),
                   ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink  ,
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                ),child: Text("Cancel ",style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),))


              ],

            )
          ],
        ),
      ),
    );
  }
}
