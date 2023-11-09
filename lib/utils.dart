import 'package:intl/intl.dart';

class AppUtils {

  static String formatDateTimeStringToLocal(DateTime dateTime) {
    // Convert to the local time zone
    DateTime localDateTime = dateTime.toLocal();

    // Format the local DateTime object
    String formattedDateTime = DateFormat('dd-MMM-yyyy HH:mm:ss').format(localDateTime);

    return formattedDateTime;
  }


}
