import 'package:intl/intl.dart';

String convertDateFrom(String date) {
  try {
    final dateFormat = DateFormat("E, d MMM yyyy HH:mm:ss Z").parse(date);
    return DateFormat("MMM d, h:mm a").format(dateFormat).toString();
  } catch (e) {
    return date;
  }
}
