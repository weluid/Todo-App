import 'package:intl/intl.dart';

class GetId{

  //get id by time seconds
  String genIDByDatetimeNow() {
    return DateFormat('yyyyMMddHHmmss').format(DateTime.now());
  }
}