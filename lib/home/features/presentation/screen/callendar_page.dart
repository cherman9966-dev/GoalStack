import 'package:flutter/material.dart';

class CallendarPage extends StatefulWidget {
  const CallendarPage({super.key});

  @override
  State<CallendarPage> createState() => _CallendarPageState();
}

class _CallendarPageState extends State<CallendarPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Text('Calendar', style: TextStyle(fontSize: 24))],
    );
  }
}
