import 'package:intl/intl.dart';

String formatDateTime(DateTime createdAt) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final createdDay = DateTime(createdAt.year, createdAt.month, createdAt.day);

  if (createdDay == today) {
    return "Today ${DateFormat("h:mm a").format(createdAt)}";
  } else if (createdDay == yesterday) {
    return "Yesterday ${DateFormat("h:mm a").format(createdAt)}";
  } else {
    final dayName = DateFormat("E").format(createdAt); // Mon, Tue ...
    return "$dayName, ${DateFormat("MMM d h:mm a").format(createdAt)}";
  }
}
