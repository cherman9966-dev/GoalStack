import 'package:flutter/material.dart';
import 'package:goalstack/home/features/presentation/widgets/custom_botom_bar.dart';
import 'package:goalstack/home/features/presentation/widgets/home_app_bar.dart';

class CallendarPage extends StatefulWidget {
  const CallendarPage({super.key});

  @override
  State<CallendarPage> createState() => _CallendarPageState();
}

class _CallendarPageState extends State<CallendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/main_background2.png',
              fit: BoxFit.cover,
            ),
          ),
          // const SafeArea(
          //   bottom: false,
          //   child: Column(children: [
          //     HomeAppBar()
          //   ]),
          // ),
          const Align(
            alignment: Alignment.center,
            child: Center(
              child: Text(
                "Тут буде календар",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
