class StreakCalculator {
  static int calculate(List<bool> weekDaysStatus) {
    int currentStreak = 0;

    // Шукаємо, де стоїть останній запалений вогник (щоб не йти в порожнє "майбутнє")
    int stopIndex = weekDaysStatus.lastIndexWhere(
      (isCompleted) => isCompleted == true,
    );

    // Якщо жоден вогник не горить взагалі
    if (stopIndex == -1) return 0;
    for (int i = 0; i <= stopIndex; i++) {
      if (weekDaysStatus[i] == true) {
        // ✅ День виконано: продовжуємо серію
        currentStreak++;
      } else {
        currentStreak = 0;
      }
    }

    return currentStreak;
  }
}
