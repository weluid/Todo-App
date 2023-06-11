import 'package:todo/repository/database/any_db.dart';
import 'package:todo/repository/database/base_database.dart';
import 'package:todo/repository/database/local_db.dart';

enum Database { localDB, anyDB }

extension DatabaseUtils on Database {
  BaseDatabase getCurrentDatabase() => this == Database.localDB ? LocalDB() : AnyDB();
}
