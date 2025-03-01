import 'package:intl/intl.dart';

String timeFormater(DateTime dateTime) {
  return DateFormat("dd-MMM-yy HH:mm a").format(dateTime);
}
