import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart';
import 'package:goalstack/home/features/presentation/widgets/card/logic/dynamic_motivator.dart';
import 'package:goalstack/home/features/presentation/widgets/card/logic/goal_fire_row.dart';
import 'package:goalstack/home/features/presentation/widgets/card/logic/streak_calculator.dart';
import 'package:goalstack/home/features/presentation/widgets/popup_dialogs/streak_congrats_dialog.dart';
import 'package:goalstack/home/features/presentation/widgets/popup_dialogs/streak_fail_dialog.dart';

class GoalCard extends ConsumerStatefulWidget {
  final GoalEntity goal;
  final VoidCallback onDelete;
  final Function(GoalEntity) onUpdate;

  const GoalCard({
    super.key,
    required this.goal,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  ConsumerState<GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends ConsumerState<GoalCard> {
  late List<bool> _weekDaysStatus;

  @override
  void initState() {
    super.initState();
    _weekDaysStatus = List.from(widget.goal.weekDaysStatus);
  }

  @override
  void didUpdateWidget(covariant GoalCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.goal != widget.goal) {
      setState(() {
        _weekDaysStatus = List.from(widget.goal.weekDaysStatus);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int activeFires = _weekDaysStatus
        .where((isCompleted) => isCompleted)
        .length;

    final int liveStreak = StreakCalculator.calculate(_weekDaysStatus);

    int targetCount = 7;
    if (widget.goal.goalType == 'custom') {
      targetCount = widget.goal.customTargetDays;
    } else if (widget.goal.goalType == 'calendar') {
      targetCount = widget.goal.calendarSelectedDays
          .where((day) => day == true)
          .length;
    }
    final int totalStreak = (widget.goal.streak * targetCount) + liveStreak;

    return Dismissible(
      key: ValueKey(widget.goal.id),
      direction: DismissDirection.endToStart,
      dismissThresholds: const {DismissDirection.endToStart: 0.2},

      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_outline, color: Colors.black, size: 32),
      ),

      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              // Робимо фон Dialog прозорим
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              // Відступи від країв екрану
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  // 1. ТВІЙ ФІРМОВИЙ ГРАДІЄНТ (темний синій преміум)
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFF1EFE9).withOpacity(0.95),
                      const Color(0xFF9E978E).withOpacity(0.90),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  // 2. ТОНКА РАМКА ЯК НА КАРТКАХ
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Щоб висота була по контенту
                  children: [
                    // Іконка для акценту (🗑️)
                    const Text('🗑️', style: TextStyle(fontSize: 40)),
                    const SizedBox(height: 16),

                    const Text(
                      'Delete Goal?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Are you sure you want to delete this goal? This action cannot be undone.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        // Кнопка Cancel
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.black12),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Кнопка Delete (Акцентна, червона, небезпечна дія)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent.withOpacity(
                                0.8,
                              ),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'Delete Goal',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },

      onDismissed: (direction) {
        widget.onDelete();
      },

      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          context.push('/add_goal', extra: widget.goal);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const  Color(0xFFEAE5DA),
                const  Color(0xFFEAE5DA),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            //border: Border.all(color: Colors.black, width: 0.3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(widget.goal.icon, color: widget.goal.color, size: 32),
                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      widget.goal.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$totalStreak days streak!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 1.0),

                      DynamicMotivator(
                        activeFires: activeFires,
                        totalFires: _weekDaysStatus.length,
                      ),
                    ],
                  ),
                ],
              ),

              if (widget.goal.description != null &&
                  widget.goal.description!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                    bottom: 14.0,
                    left: 48.0,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.85,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.goal.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        height: 1.0,
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(height: 24),

              GoalFiresRow(
                goal: widget.goal,
                weekDaysStatus: _weekDaysStatus,
                onFireTapped: (index) async {
                  setState(() {
                    _weekDaysStatus[index] = !_weekDaysStatus[index];
                  });

                  final updatedGoal = widget.goal;
                  updatedGoal.weekDaysStatus = List.from(_weekDaysStatus);
                  widget.onUpdate(updatedGoal);

                  final bool isAllDaysCompleted = _weekDaysStatus.every(
                    (status) => status == true,
                  );
                  final bool isLastFire = index == _weekDaysStatus.length - 1;
                  final bool isToggledOn = _weekDaysStatus[index] == true;

                  if (isAllDaysCompleted) {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.6),
                      builder: (context) {
                        return StreakCongratsDialog(goalId: widget.goal.id);
                      },
                    );
                  } else if (isLastFire && isToggledOn) {
                    // Якщо натиснуто останній вогник, але не всі виконані
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.6),
                      builder: (context) {
                        return GoalFailPopup(
                          goalId: widget.goal.id,
                          completedDays: activeFires,
                          targetDays: _weekDaysStatus.length,
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
