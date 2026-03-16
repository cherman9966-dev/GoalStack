import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConfettiOverlay extends StatefulWidget {
  final bool playAnimation;

  const ConfettiOverlay({super.key, required this.playAnimation});

  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPlaying = false; // ❗️ Ця змінна відповідатиме за те, чи бачимо ми салют

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    // ❗️ Слухаємо контролер: як тільки салют відстріляв - ховаємо його
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          setState(() {
            _isPlaying = false; // Робимо знову прозорим
          });
        }
      }
    });
  }

  @override
  void didUpdateWidget(ConfettiOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Якщо ми запалили вогник (з false на true)
    if (!oldWidget.playAnimation && widget.playAnimation) {
      setState(() {
        _isPlaying = true; // 1. Робимо салют видимим
      });
      _controller.forward(from: 0); // 2. Стріляємо!
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      // ❗️ Opacity ховає оту сіру хмарку, поки ми не натиснули на кнопку
      child: Opacity(
        opacity: _isPlaying ? 1.0 : 0.0,
        child: Lottie.asset(
          'assets/animations/firework.json',
          controller: _controller,
          onLoaded: (composition) {
            // Налаштовуємо точний час анімації з файлу
            _controller.duration = composition.duration;
          },
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}