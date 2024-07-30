import 'package:intl/intl.dart';

String gettingDayDate() {
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(now);
}

//