import 'package:intl/intl.dart';

String dateFormat(DateTime? dateTime) {
  if (dateTime != null) {
    String date = DateFormat('dd MMM yy').format(dateTime);
    return date;
  } else {
    return '';
  }
}

String dateFormatter(String? dateStr) {
  if (dateStr != null && dateStr.isNotEmpty) {
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  } else {
    return '';
  }
}
