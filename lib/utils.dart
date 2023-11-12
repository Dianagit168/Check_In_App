import 'package:intl/intl.dart';

class AppUtils {

  static String formatDateTimeStringToLocal(DateTime dateTime) {
    // Convert to the local time zone
    DateTime localDateTime = dateTime.toLocal();

    // Format the local DateTime object
    String formattedDateTime = DateFormat('MM/dd/yyyy, HH:mm:ss a').format(localDateTime);

    return formattedDateTime;
  }


}
