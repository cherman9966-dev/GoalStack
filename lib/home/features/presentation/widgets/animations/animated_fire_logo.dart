import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedFireLogo extends StatefulWidget {
  final String mainLogoPath;
  final String sparkPath;

  const AnimatedFireLogo({
    super.key,
    required this.mainLogoPath,
    required this.sparkPath,
    required size,
  });

  @override
  State<AnimatedFireLogo> createState() => _AnimatedFireLogoState();
}

class _AnimatedFireLogoState extends State<AnimatedFireLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // Кути, під якими будуть вилітати вогники (всі направлені вгору і в сторони)
  final List<double> _angles = [
    -pi / 2, // Рівно вгору
    -pi / 3, // Вгору і вправо
    -2 * pi / 3, // Вгору і вліво
    -pi / 6, // Сильно вправо
    -5 * pi / 6, // Сильно вліво
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _emitSparks() {
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _emitSparks,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 75,
        width: 120,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ...List.generate(5, (index) {
              return AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final double distance = _animation.value * 45;
                  final double dx = cos(_angles[index]) * distance;
                  final double dy = sin(_angles[index]) * distance;
                  final double opacity = 1.0 - _animation.value;

                  return Transform.translate(
                    offset: Offset(dx, dy),
                    child: Opacity(opacity: opacity, child: child),
                  );
                },
                child: Image.asset(widget.sparkPath, height: 30),
              );
            }),
            Image.asset(widget.mainLogoPath, height: 100),
          ],
        ),
      ),
    );
  }
}
