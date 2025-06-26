import 'package:intl/intl.dart';

class FormateDateAndTime {
  static String getTimeAgo(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    

    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60 && difference.inSeconds > 0) {
      return '${difference.inSeconds} sec ago';
    } else if (difference.inMinutes < 60 && difference.inMinutes > 0) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24 && difference.inHours > 0) {
      return '${difference.inHours} hr ago';
    } else {
       return '${difference.inDays}d ago';
       
    }
  }

  static String getMonthYear(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    String monthYear = DateFormat('MMM yyyy').format(dateTime);
        return monthYear;
  }
}
