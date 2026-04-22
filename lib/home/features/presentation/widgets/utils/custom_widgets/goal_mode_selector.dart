import 'package:flutter/material.dart';

class GoalModeSelector extends StatelessWidget {
  final String goalType;
  final int customDaysCount;
  final List<bool> calendarSelectedDays;
  final Color selectedColor;

  // Функції зворотного зв'язку (Callbacks), щоб повідомляти батька про зміни
  final ValueChanged<String> onTypeChanged;
  final ValueChanged<int> onCustomDaysChanged;
  final ValueChanged<int> onCalendarDayToggled;

  const GoalModeSelector({
    super.key,
    required this.goalType,
    required this.customDaysCount,
    required this.calendarSelectedDays,
    required this.selectedColor,
    required this.onTypeChanged,
    required this.onCustomDaysChanged,
    required this.onCalendarDayToggled,
  });

  // Локальна константа для назв днів
  static const List<String> _shortDayNames = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Target mode',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),

        _buildTypeSelector(),

        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Column(
            children: [
              if (goalType == 'custom') _buildCustomDaysSettings(),
              if (goalType == 'calendar') _buildCalendarSettings(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF091428).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _buildTypeOption('All Days', 'all_days'),
          _buildTypeOption('Custom', 'custom'),
          _buildTypeOption('Calendar', 'calendar'),
        ],
      ),
    );
  }

  Widget _buildTypeOption(String title, String type) {
    final isSelected = goalType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTypeChanged(type), // Передаємо новий тип наверх
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF122246) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: Colors.white.withOpacity(0.2))
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomDaysSettings() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Days per week:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: customDaysCount > 1
                    ? () => onCustomDaysChanged(customDaysCount - 1)
                    : null,
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.white70,
                ),
              ),
              Text(
                '$customDaysCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: customDaysCount < 7
                    ? () => onCustomDaysChanged(customDaysCount + 1)
                    : null,
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSettings() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (index) {
          final isSelected = calendarSelectedDays[index];
          return GestureDetector(
            onTap: () => onCalendarDayToggled(index),
            // Передаємо індекс дня наверх
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? selectedColor
                    : const Color(0xFF091428).withOpacity(0.5),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.2),
                ),
              ),
              child: Center(
                child: Text(
                  _shortDayNames[index],
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
