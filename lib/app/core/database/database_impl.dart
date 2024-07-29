import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timer/app/entities/project.dart';
import 'package:timer/app/entities/project_task.dart';

import './database.dart';

class DatabaseImpl implements Database {
  Isar? _dataBaseInstace;

  @override
  Future<Isar> openConnection() async {
    if (_dataBaseInstace == null) {
      final dir = await getApplicationSupportDirectory();
      _dataBaseInstace = await Isar.open(
        [ProjectTaskSchema, ProjectSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return _dataBaseInstace!;
  }
}
