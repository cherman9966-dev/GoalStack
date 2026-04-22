import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart';
import 'package:goalstack/home/features/presentation/providers/goal_list_provider.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/custom_widgets/goal_mode_selector.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/custom_widgets/primary_gradient_button.dart';

class AddGoalPage extends ConsumerStatefulWidget {
  final GoalEntity? goalToEdit;

  const AddGoalPage({super.key, this.goalToEdit});

  @override
  ConsumerState<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends ConsumerState<AddGoalPage> {

  String _goalType = 'all_days';
  int _customDaysCount = 3; // Для режиму Custom
  List<bool> _calendarSelectedDays = List.filled(7, false); // Для режиму Calendar
  final List<String> _shortDayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  final TextEditingController _descController = TextEditingController();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late Color _selectedColor;
  late IconData _selectedIcon;

  bool get isEditMode => widget.goalToEdit != null;

  final List<IconData> _goalIcons = [
    Icons.fitness_center,
    Icons.menu_book,
    Icons.water_drop,
    Icons.work_outline,
    Icons.directions_run,
    Icons.self_improvement,
    Icons.attach_money,
    Icons.language,
    Icons.music_note,
    Icons.flight,
    Icons.local_dining,
    Icons.smoke_free,
    Icons.timer_outlined,
    Icons.directions_car,
    Icons.list_outlined,
    Icons.pets,
    Icons.home,
    Icons.eco,
    Icons.favorite_border,
    Icons.palette,
    Icons.savings,
    Icons.laptop_mac,
    Icons.bedtime,
  ];

  // String? _selectedTime;
  final List<Color> _colors = [
    const Color(0xFFFF6B00), // Помаранчевий
    const Color(0xFFFFB800), // Жовтий
    const Color(0xFF00C48C), // Зелений
    const Color(0xFF0084F4), // Синій
    const Color(0xFF6A4CFF), // Фіолетовий
    const Color(0xFF2C3E50), // Темно-синій
    const Color(0xFF95A5A6), // Сірий
  ];

  @override
  void initState() {
    super.initState();

    final goal = widget.goalToEdit;

    if (goal != null) {
      _titleController = TextEditingController(text: goal.title);
      _descriptionController = TextEditingController(
        text: goal.description ?? '',
      );
      _selectedColor = goal.color ?? _colors[0];
      _selectedIcon = goal.icon ?? _goalIcons[0];
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();

      _selectedColor = _colors[0];
      _selectedIcon = _goalIcons[0];
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a topic title'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    if (isEditMode) {
      final updatedGoal = widget.goalToEdit!
        ..title = title
        ..description = _descriptionController.text.trim()
        ..color = _selectedColor
        ..icon = _selectedIcon;

      await ref.read(goalListProvider.notifier).updateGoal(updatedGoal);

    } else {
      // СТВОРЕННЯ
      // 1. Вираховуємо, скільки вогників нам потрібно створити
      int firesCount = 7; // За замовчуванням для 'all_days'
      if (_goalType == 'custom') {
        firesCount = _customDaysCount;
      } else if (_goalType == 'calendar') {
        // Рахуємо, скільки днів (true) юзер виділив у календарі
        firesCount = _calendarSelectedDays.where((day) => day == true).length;
      }

      // 2. Створюємо ціль з новими полями
      final newGoal = GoalEntity()
        ..title = title
        ..description = description
        ..createdAt = DateTime.now()
        ..status = 'active'
        ..streak = 0
        ..isCompleted = false
        ..color = _selectedColor
        ..icon = _selectedIcon
      // --- НОВІ ПОЛЯ ---
        ..goalType = _goalType
        ..customTargetDays = _customDaysCount
        ..calendarSelectedDays = _calendarSelectedDays
      // --- ДИНАМІЧНІ ВОГНИКИ ---
        ..weekDaysStatus = List.filled(firesCount, false);

      await ref.read(goalListProvider.notifier).addGoal(newGoal);
    }

    if (mounted) {
      print('Goal: $title, color: $_selectedColor');
      context.go('/my_topic_page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add Goal',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              context.pop();
            } else {
              context.go('/my_topic_page');
            }
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Твій фірмовий темний фон
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/main_background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 14.0,
            ),
            child: Container(
              padding: const EdgeInsets.all(23.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF122246).withOpacity(0.25),
                    const Color(0xFF091428).withOpacity(0.45),
                  ],
                ),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. MAIN TOPIC
                  _buildLabel('Main topic'),
                  _buildTextField(
                    hint: 'Enter main topic',
                    controller: _titleController,
                  ),
                  const SizedBox(height: 16),

                  // Вставляємо замість старого LayoutBuilder
                  GoalModeSelector(
                    goalType: _goalType,
                    customDaysCount: _customDaysCount,
                    calendarSelectedDays: _calendarSelectedDays,
                    selectedColor: _selectedColor,
                    onTypeChanged: (type) {
                      setState(() => _goalType = type);
                    },
                    onCustomDaysChanged: (count) {
                      setState(() => _customDaysCount = count);
                    },
                    onCalendarDayToggled: (index) {
                      setState(() {
                        _calendarSelectedDays[index] = !_calendarSelectedDays[index];
                      });
                    },
                  ),


                  const SizedBox(height: 20),

                  // 3. DESCRIPTION
                  _buildLabel('Description'),
                  _buildTextField(
                    hint: 'Enter detailed description of the goal',
                    controller: _descriptionController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 15),

                  // 4. GOAL COLOR
                  _buildLabel('Goal color'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _colors
                        .map((color) => _buildColorCircle(color))
                        .toList(),
                  ),
                  const SizedBox(height: 18),

                  // 5. GOAL STATUS
                  _buildLabel('Goal icon'),
                  _buildIconSelector(),
                  const SizedBox(height: 35),

                  // 6. КНОПКА CREATE GOAL
                  PrimaryGradientButton(
                    text: isEditMode ? 'Save Changes' : 'Create Topic',
                    onPressed: _handleSave,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- ДОПОМІЖНІ ВІДЖЕТИ (Щоб код був чистим) ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 15),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildColorCircle(Color color) {
    final isSelected = _selectedColor == color;
    return GestureDetector(
      onTap: () => setState(() => _selectedColor = color),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: isSelected
            ? const Icon(Icons.check_sharp, color: Colors.white, size: 28)
            : null,
      ),
    );
  }

  Widget _buildIconSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: _goalIcons.map((icon) {
          final isSelected = _selectedIcon == icon;
          return GestureDetector(
            onTap: () => setState(() => _selectedIcon = icon),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? _selectedColor
                    : const Color(0xFF1A2A4A).withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.white24,
                ),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white54,
                size: 26,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
