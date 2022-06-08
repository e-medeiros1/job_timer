import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_task.dart';
import 'package:path_provider/path_provider.dart';

import './database.dart';

class DatabaseImpl implements Database {
  //Conceito de singleton
  Isar? _databaseInstance;

  //Método para abrir conexão
  @override
  Future<Isar> openConnection() async {
    if (_databaseInstance == null) {
      //Buscando diretório com PathProvider
      final dir = await getApplicationSupportDirectory();
      _databaseInstance = await Isar.open(
        schemas: [ProjectTaskSchema, ProjectSchema],
        directory: dir.path,
        inspector: true,
      );
    } 
      return _databaseInstance!;
    
  }
}
