import 'package:flutter/material.dart';
import 'package:goalstack/home/features/presentation/widgets/home_app_bar.dart';

class MyTopicPage extends StatelessWidget {
  const MyTopicPage({super.key});

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
          const SafeArea(
            bottom: false,
            child: Column(children: [
              HomeAppBar()
            ]),
          ),
          const Align(
            alignment: Alignment.center,
            child: Center(
              child: Text(
                "Topic Page",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
