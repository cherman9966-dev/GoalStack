import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/core/utils/day_extensions.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart';
import 'package:goalstack/home/features/presentation/providers/goal_list_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends ConsumerStatefulWidget {
  final double calendarPadding;
  final double calendarBorderRadius;
  final String? backgroundImagePath;
  final Color cardBackgroundColor;

  const CalendarPage({
    super.key,
    this.calendarPadding = 20.0,
    this.calendarBorderRadius = 24.0,
    this.backgroundImagePath,
    this.cardBackgroundColor = const Color(0xFF161B2E),
  });

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final goals = ref.watch(goalListProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/log_background_fon.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(widget.calendarPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(widget.calendarBorderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((255 * 0.3).round()),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2024, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.black),
                      rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.black),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(widget.calendarBorderRadius)),
                      ),
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                      weekendStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: const TextStyle(color: Colors.black),
                      weekendTextStyle: const TextStyle(color: Colors.black),
                      todayTextStyle: const TextStyle(color: Colors.black),
                      todayDecoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                      selectedTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      selectedDecoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 3),
                        shape: BoxShape.circle,
                      ),
                    ),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, date, events) {
                        final dateOnly = date.dateOnly;
                        final activeGoals = goals.where((g) => g.completedDates.contains(dateOnly)).toList();
                        final streakGoals = goals.where((g) => g.streakEarnedDates.contains(dateOnly)).toList();

                        if (activeGoals.isEmpty && streakGoals.isEmpty) {
                          return null;
                        }


                        return Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            if (streakGoals.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.orangeAccent, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            if (activeGoals.isNotEmpty)
                              Positioned(
                                top: -1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: activeGoals.take(5).map((g) =>
                                      Container(
                                        width: 6,
                                        height: 6,
                                        margin: const EdgeInsets.symmetric(horizontal: 1),
                                        decoration: BoxDecoration(
                                            color: g.color ?? Colors.orange,
                                            shape: BoxShape.circle),
                                      )
                                  ).toList(),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),

              const Divider(color: Colors.white12, indent: 20, endIndent: 20),

              Expanded(
                child: _buildTimeline(goals),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline(List<GoalEntity> goals) {
    final selectedDate = _selectedDay?.dateOnly;
    final now = DateTime.now().dateOnly;


    final displayGoals = goals.where((g) {
      final bool isCompletedToday = g.completedDates.contains(selectedDate);
      final bool isMissed = selectedDate != null &&
          selectedDate.isBefore(now) &&
          !isCompletedToday;
      return isCompletedToday || isMissed;
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: displayGoals.length,
      itemBuilder: (context, index) {
        final goal = displayGoals[index];
        final bool isGoalFinished = goal.isCompleted;
        final bool isCompletedToday = goal.completedDates.contains(selectedDate);
        
        final bool isFailedStreak = selectedDate != null &&
            selectedDate.isBefore(now) &&
            !isCompletedToday;

        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF122246).withOpacity(0.45),
                const Color(0xFF091428).withOpacity(0.45),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              // НОВЕ: Колір рамки
              color: isFailedStreak
                  ? Colors.redAccent.withOpacity(0.8) // Червоний для провалу
                  : (isGoalFinished
                  ? Colors.orangeAccent.withOpacity(0.8) // Золотий для кубка
                  : Colors.white.withOpacity(0.18)), // Стандарт
              width: isFailedStreak ? 2.0 : 1.0, // Товща рамка для провалу
            ),
          ),
          child: Row(
            children: [
              // Іконка
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (isFailedStreak ? Colors.red :
                  (goal.color ?? Colors.orange)).withAlpha((255 * 0.15).round()),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isFailedStreak ? Icons.close : (goal.icon ?? Icons.check_circle),
                  color: isFailedStreak ? Colors.redAccent : (goal.color ?? Colors.orange),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.title,
                      style: TextStyle(
                        color: isFailedStreak ? Colors.white70 : Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isFailedStreak
                          ? 'Missed day ❌'
                          : (isGoalFinished ? 'Goal achieved! 🔥' : 'Activity tracked'),
                      style: TextStyle(
                        color: isFailedStreak ? Colors.redAccent.withAlpha((255 * 0.7).round()) :
                        Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              if (isGoalFinished && !isFailedStreak)
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('🏆', style: TextStyle(fontSize: 24)),
                ),
            ],
          ),
        );
      },
    );
  }
}