import 'package:intl/intl.dart';

String convertDateFrom(String date) {
  try {
    final dateFormat = DateFormat("E, d MMM yyyy HH:mm:ss Z").parse(date);
    return DateFormat("MMM d, h:mm a").format(dateFormat).toString();
  } catch (e) {
    return date;
  }
}

bool isAfterDate(String firstDate, String lastDate) {
  try {
    final firstFormat = DateFormat("E, d MMM yyyy HH:mm:ss Z").parse(firstDate);
    final lastFormat = DateFormat("E, d MMM yyyy HH:mm:ss Z").parse(lastDate);
    return firstFormat.compareTo(lastFormat) > 0;
  } catch (e) {
    return false;
  }
}
