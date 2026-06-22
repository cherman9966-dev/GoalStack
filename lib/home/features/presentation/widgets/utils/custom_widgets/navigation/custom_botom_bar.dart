import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/custom_widgets/navigation/crystal_add_button.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key, required int currentIndex});
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/calendar')) return 1;
    if (location.startsWith('/artifacts')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(context);


    return SafeArea(
      child: Padding(
        // Відступи від країв екрану
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // Розсуваємо по краях
          children: [
            // --- ЛІВИЙ ОСТРІВЕЦЬ (Навігація: Home, Calendar) ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),

              decoration: BoxDecoration(
                color: const Color(0xFFF1EFE9).withOpacity(0.7),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  // Ледь помітна сіра рамка
                  width: 1,
                ),
                // Легка тінь
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _buildNavItem(
                    context: context,
                    icon: Icons.home_filled, // Залита іконка
                    isActive: currentIndex == 0,
                    route: '/my_topic_page',
                  ),
                  const SizedBox(width: 6), // Відстань між кнопками
                  _buildNavItem(
                    context: context,
                    icon: Icons.calendar_month_outlined, // Контурна іконка
                    isActive: currentIndex == 1,
                    route: '/calendar',
                  ),const SizedBox(width: 6), // Відстань між кнопками
                  _buildNavItem(
                    context: context,
                    icon: Icons.architecture_outlined, // Контурна іконка
                    isActive: currentIndex == 2,
                    route: '/artifacts',
                  ),
                ],
              ),
            ),

            // --- ПРАВИЙ ОСТРІВЕЦЬ (Кнопка створення +) ---
            // Виклик з дефолтними розмірами (70x70)
            CustomCrystalButton(
              onTap: () => context.go('/add_goal'),
            ),
          ],
        ),
      ),
    );
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFDED9D1),
                    // Світліший синій
                    const Color(0xFF9E978E)
                    // Основний колір, але м'якший
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isActive
                ? Colors.white.withOpacity(0.28)
                : Colors.transparent,
          ),
          // Додамо невелике світіння (shadow) для ефекту світлішої кнопки
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const  Color(0xFFDED9D1).withOpacity(0.9),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: 22,
          color: isActive ? Colors.black : Colors.black.withOpacity(0.4),
        ),
      ),
    );
  }
}
