import 'package:flutter/material.dart';

class GoalCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final int streak;
  // Початковий стан вогників (true - виконано, false - ні)
  final List<bool> initialWeekDays;
  // Функція, яка спрацює, коли користувач підтвердить видалення
  final VoidCallback onDelete;

  const GoalCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.streak,
    required this.initialWeekDays,
    required this.onDelete,
  });

  @override
  State<GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  late List<bool> _weekDaysStatus;
  final List<String> _dayNames = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  @override
  void initState() {
    super.initState();
    // Копіюємо початковий стан, щоб мати змогу його змінювати при кліку
    _weekDaysStatus = List.from(widget.initialWeekDays);
  }

  @override
  Widget build(BuildContext context) {
    // ❗️ Dismissible - це віджет, який додає свайп
    return Dismissible(
      key: UniqueKey(), // Унікальний ключ для картки
      direction: DismissDirection.endToStart, // Свайп ТІЛЬКИ справа наліво (вліво)

      // Фон, який видно під час свайпу (Червоний з корзиною)
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 32),
      ),

      // Вікно ПІДТВЕРДЖЕННЯ видалення
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1A2A4A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Text('Delete Goal?', style: TextStyle(color: Colors.white)),
              content: const Text('Are you sure you want to delete this goal? This action cannot be undone.', style: TextStyle(color: Colors.white70)),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // Скасувати
                  child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true), // Підтвердити
                  child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
                ),
              ],
            );
          },
        );
      },

      // Якщо підтвердили - викликаємо функцію видалення
      onDismissed: (direction) {
        widget.onDelete();
      },

      // --- САМА КАРТКА ---
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A).withOpacity(0.9), // Темно-синій фон картки
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. ВЕРХНІЙ РЯДОК
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Іконка заданого кольору
                Icon(widget.icon, color: widget.iconColor, size: 28),
                const SizedBox(width: 16),

                // Назва цілі
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, height: 1.2),
                  ),
                ),
                const SizedBox(width: 8),

                // Streak
                Text(
                  '${widget.streak} days streak!',
                  style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 2. НИЖНІЙ РЯДОК: Вогники
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final bool isCompleted = index < _weekDaysStatus.length ? _weekDaysStatus[index] : false;

                return Column(
                  children: [
                    // Кліп на кружечок
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Змінюємо стан при натисканні (було сіре -> стало рожеве)
                          _weekDaysStatus[index] = !_weekDaysStatus[index];
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.local_fire_department,
                            // ❗️ РОЖЕВИЙ КОЛІР при виконанні, сірий - якщо ні
                            color: isCompleted ? Colors.pinkAccent : Colors.grey.shade400,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Назва дня
                    Text(
                      _dayNames[index],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}