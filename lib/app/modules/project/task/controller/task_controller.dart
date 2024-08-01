import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/services/projects/project_service.dart';
import 'package:timer/app/view_model/project_model.dart';
import 'package:timer/app/view_model/project_task_model.dart';

part 'task_state.dart';

class TaskController extends Cubit<TaskStatus> {
  TaskController()
      : _projectService = Modular.get<ProjectService>(),
        super(TaskStatus.initial);

  final ProjectService _projectService;
  late final ProjectModel _projectModel;

  void setProject(ProjectModel projectModel) => _projectModel = projectModel;
  Future<void> register(String name, int duration) async {
    try {
      emit(TaskStatus.loading);
      final task = ProjectTaskModel(duration: duration, name: name);
      await _projectService.addTask(_projectModel.id!, task);
      emit(TaskStatus.success);
    } catch (e, s) {
      log('Erro salvar task', error: e, stackTrace: s);
    }
  }
}
