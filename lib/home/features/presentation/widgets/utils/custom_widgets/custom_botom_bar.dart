import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key, required int currentIndex});

  // Визначаємо активну вкладку
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/calendar')) return 1;
    // Можеш додати settings сюди пізніше, якщо потрібно
    return 0; // За замовчуванням Головна (MyTopicsPage)
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(context);

    // SafeArea потрібна, щоб панель не налізла на системну смужку "Додому" на iPhone
    return SafeArea(
      child: Padding(
        // Відступи від країв екрану
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Розсуваємо по краях
          children: [

            // --- ЛІВИЙ ОСТРІВЕЦЬ (Навігація: Home, Calendar) ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                                                   // Відступ від країв до іконок
              decoration: BoxDecoration(
                color: const Color(0xFF13151A), // Дуже темний колір фону
                borderRadius: BorderRadius.circular(40), // Форма пігулки
                border: Border.all(
                  color: Colors.white.withOpacity(0.1), // Ледь помітна сіра рамка
                  width: 1,
                ),
                // Легка тінь
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0,10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _buildNavItem(
                    context: context,
                    icon: Icons.home_filled,// Залита іконка
                    isActive: currentIndex == 0,
                    route: '/my_topic_page',
                  ),
                  const SizedBox(width: 6), // Відстань між кнопками
                  _buildNavItem(
                    context: context,
                    icon: Icons.calendar_month_outlined, // Контурна іконка
                    isActive: currentIndex == 1,
                    route: '/calendar',
                  ),
                ],
              ),
            ),

            // --- ПРАВИЙ ОСТРІВЕЦЬ (Кнопка створення +) ---
            GestureDetector(
              onTap: () => context.go('/add_goal'), // Перехід на екран створення
              child: Container(
                height: 54, // Висота овалу
                width: 86,  // Ширина овалу (робить його витягнутим)
                decoration: BoxDecoration(
                  // Градієнт як на дизайні
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8B3D), Color(0xFFFF5A00)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(32), // Сильне закруглення
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF5A00).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(Icons.add_link_outlined, color: Colors.white, size: 30),
              ),
            ),

          ],
        ),
      ),
    );
  }

  // Логіка окремої кнопки навігації (із сірим фоном для активної)
  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required bool isActive,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // Розміри кружечка підсвітки
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          // Якщо активна - малюємо світло-сірий фон, інакше - прозорий
          color: isActive ? const Color(0xFF2C2F36) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          size: 20,
          // Якщо активна - біла, інакше - темно-сіра
          color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
        ),
      ),
    );
  }
}