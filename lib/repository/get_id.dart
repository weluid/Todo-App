import 'package:intl/intl.dart';

class GetId {
  //get id by time seconds
  int genIDByDatetimeNow() {
    String formattedDate = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
    int id = int.parse(formattedDate);

    return id;
  }
}
