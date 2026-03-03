import 'package:flutter/material.dart';

class MyTopicsPage extends StatefulWidget {
  const MyTopicsPage({super.key});

  @override
  State<MyTopicsPage> createState() => _MyTopicsPageState();
}

class _MyTopicsPageState extends State<MyTopicsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Streak',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blueGrey, Colors.grey]),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_box_rounded,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.settings_rounded,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.list,
                color: Colors.black, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(child: Text('My Topics', style: TextStyle(fontSize: 24))),

    );
  }
}
