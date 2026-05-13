import 'package:flutter/material.dart';

class TimePickerPopup extends StatefulWidget {
  final String initialTime;

  const TimePickerPopup({super.key, required this.initialTime});

  @override
  State<TimePickerPopup> createState() => _CustomTimePickerPopupState();
}

class _CustomTimePickerPopupState extends State<TimePickerPopup> {
  late int selectedHour;
  late int selectedMinute;
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  @override
  void initState() {
    super.initState();
    final parts = widget.initialTime.split(':');
    selectedHour = parts.length == 2 ? int.tryParse(parts[0]) ?? 20 : 20;
    selectedMinute = parts.length == 2 ? int.tryParse(parts[1]) ?? 0 : 0;

    _hourController = FixedExtentScrollController(initialItem: selectedHour);
    _minuteController = FixedExtentScrollController(initialItem: selectedMinute);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // Робимо системний фон прозорим
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: const EdgeInsets.all(24),
        // Твій фірмовий дизайн з градієнтом
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1E3A7A).withOpacity(0.8),
              const Color(0xFF122246).withOpacity(0.80),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Reminder Time',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Блок з барабанами прокрутки (Години : Хвилини)
            SizedBox(
              height: 160, // Висота нашого скрол-барабана
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 160,
                    clipBehavior: Clip.antiAlias,

                    decoration: BoxDecoration(
                      color: const Color(0xFF0A1329),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 1.2,
                      ),

                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.7), // Тінь зверху
                          Colors.transparent,            // Світлий центр
                          Colors.black.withOpacity(0.7), // Тінь знизу
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                    child: ListWheelScrollView.useDelegate(
                      controller: _hourController,
                      itemExtent: 40,
                      perspective: 0.009,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() => selectedHour = index);
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 24, // Від 0 до 23 годин
                        builder: (context, index) {
                          final isSelected = index == selectedHour;
                          return Center(
                            child: Text(
                              index.toString().padLeft(2, '0'),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                // Робимо сусідні цифри більш тьмяними (опасіті 0.25 як у хвилин)
                                    : Colors.white.withOpacity(0.55),
                                fontSize: isSelected ? 24 : 20,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // РОЗДІЛЮВАЧ
                  // ВІНТАЖНИЙ РОЗДІЛЮВАЧ (Механічні індикаторні крапки)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: SizedBox(
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ВЕРХНЯ КРАПКА ("Фізична лінза")
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFF0A1329),
                                width: 1.5,
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),

                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // НИЖНЯ КРАПКА
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFF0A1329),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // БАРАБАН ХВИЛИН (0 - 59)
                  Container(
                    width: 50,
                    height: 160,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A1329),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 1.2,
                      ),

                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.7), // Тінь зверху
                          Colors.transparent,            // Світлий центр
                          Colors.black.withOpacity(0.7), // Тінь знизу
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                    child: ListWheelScrollView.useDelegate(
                      controller: _minuteController,
                      itemExtent: 40,
                      perspective: 0.009, // Зберігаємо твій кут огляду
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() => selectedMinute = index);
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 60,
                        builder: (context, index) {
                          final isSelected = index == selectedMinute;
                          return Center(
                            child: Text(
                              index.toString().padLeft(2, '0'),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                // Невибрані цифри робимо ще трохи тьмянішими для фокусу на центрі
                                    : Colors.white.withOpacity(0.55),
                                fontSize: isSelected ? 24 : 20,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 28),

            // КНОПКИ ДІЙ
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context), // Повертає null (скасування)
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white.withOpacity(0.6)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {
                    final formattedTime = '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')}';
                    Navigator.pop(context, formattedTime);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white.withOpacity(0.6)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}