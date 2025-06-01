import 'package:intl/intl.dart';

class CustomDate {
  static String formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('MMMM dd, yyyy').format(date);
    } catch (e) {
      return 'Invalid date';
    }
  }
}