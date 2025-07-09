import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toOrderDateFormat() {
    // Format example: 2025-06-04 at 09:30 o'clock
    final datePart = DateFormat('yyyy-MM-dd HH:mm').format(this);
    final timePart = DateFormat('HH:mm').format(this);
    return '${datePart} ${timePart}';
  }
}

// Helper method if you're still dealing with nullable strings
String formatOrderDate(String? dateString) {
  if (dateString == null) return '';

  try {
    final dateTime = DateTime.parse(dateString);
    return dateTime.toOrderDateFormat();
  } catch (e) {
    return dateString; // fallback if parsing fails
  }
}
