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
      body: Center(child: Text('My Topics', style: TextStyle(fontSize: 24))),
    );
  }
}
