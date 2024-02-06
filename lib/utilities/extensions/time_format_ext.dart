import 'package:intl/intl.dart';

extension TimeFormatExt on DateTime {
  String get toTimeFormatted => DateFormat('jmv').format(this);

  String get toDateFormatted => DateFormat('yyyy-MM-dd').format(this);
}
