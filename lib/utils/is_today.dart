bool? isToday(DateTime? date) {
  final now = DateTime.now();
  final result = date?.year == now.year && date?.month == now.month && date?.day == now.day;
  return result;
}
