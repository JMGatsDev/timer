import 'dart:developer';

import 'package:timer/app/core/database/database.dart';
import 'package:timer/app/core/exceptions/failure.dart';
import 'package:timer/app/entities/project.dart';
import 'package:isar/isar.dart';
import 'package:timer/app/entities/project_status.dart';
import 'package:timer/app/entities/project_task.dart';
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

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    final connection = await _dataBase.openConnection();
    final project = await findById(projectId);
    await connection.writeTxn(
      () async {
        await connection.projectTasks.put(task);
        project.tasks.add(task);
        return project.tasks.save();
      },
    );

    return project;
  }

  @override
  Future<Project> findById(int projectId) async {
    final connection = await _dataBase.openConnection();
    final project = await connection.projects.get(projectId);
    if (project == null) {
      throw Failure(message: 'Projeto não encontrado');
    }
    return project;
  }

  @override
  Future<void> finish(int projectId) async {
    try {
      final connection = await _dataBase.openConnection();
      final project = await findById(projectId);
      project.status = ProjectStatus.finalizado;
      await connection.writeTxn(() => connection.projects.put(
            project,
          ));
    } on IsarError catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      throw Failure(message: 'Erro ao finalizar projeto');
    }
  }
}
