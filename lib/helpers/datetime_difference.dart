import 'package:intl/intl.dart';

String formatDateTimeDifference(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inHours < 24) {
    return "${difference.inHours} hours ago";
  } else {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }
}