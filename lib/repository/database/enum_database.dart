import 'package:todo/repository/database/any_db.dart';
import 'package:todo/repository/database/base_database.dart';
import 'package:todo/repository/database/cache_manager.dart';

enum Database { localDB, anyDB }

extension DatabaseUtils on Database {
  BaseDatabase getCurrentDatabase() => this == Database.localDB ? CacheManager() : AnyDB();
}
