import 'dart:developer';

import 'package:timer/app/core/database/database.dart';
import 'package:timer/app/core/exceptions/failure.dart';
import 'package:timer/app/entities/project.dart';
import 'package:isar/isar.dart';
import 'package:timer/app/entities/project_status.dart';
import './project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  ProjectRepositoryImpl({required Database dataBase}) : _dataBase = dataBase;

  final Database _dataBase;

  @override
  Future<void> register(Project project) async {
    try {
      final connection = await _dataBase.openConnection();
      await connection.writeTxn(
        () {
          return connection.projects.put(project);
        },
      );
    } on IsarError catch (e, s) {
      log('Error ao cadastrar Projeto', error: e, stackTrace: s);
      throw Failure(message: 'Error ao cadastrar Projeto');
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    final connection = await _dataBase.openConnection();
    final projects =
        await connection.projects.filter().statusEqualTo(status).findAll();

    return projects;
  }
}
