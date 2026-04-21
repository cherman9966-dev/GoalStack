import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/custom_widgets/primary_gradient_button.dart';

class EmptyTopicScreen extends StatefulWidget {
  const EmptyTopicScreen({super.key});

  @override
  State<EmptyTopicScreen> createState() => _EmptyTopicScreenState();
}

class _EmptyTopicScreenState extends State<EmptyTopicScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _levitationAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _levitationAnimation = Tween<double>(begin: 0, end: -16).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _levitationAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _levitationAnimation.value),
                  child: child,
                );
              },
              child: Image.asset(
                'assets/icons/vector_flame.png',
                height: 140,
                color: Colors.white.withOpacity(0.5),
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 28),

            // Текст
            const Text(
              'Create a topic and check in with\none tap.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32),

            PrimaryGradientButton(
              text: 'Сreate Topic',
              onPressed: () {
                context.push('/add_goal');
              },
            ),
          ],
        ),
      ),
    );
  }
}