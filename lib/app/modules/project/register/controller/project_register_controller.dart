import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/entities/project_status.dart';
import 'package:timer/app/services/projects/project_service.dart';
import 'package:timer/app/view_model/project_model.dart';
part 'project_register_state.dart';

class ProjectRegisterController extends Cubit<ProjectRegisterStatus> {
  final ProjectService _projectService;

  ProjectRegisterController()
      : _projectService = Modular.get<ProjectService>(),
        super(ProjectRegisterStatus.inicial);

  Future<void> register(String name, int estimate) async {
    emit(ProjectRegisterStatus.loading);
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      final project = ProjectModel(
        name: name,
        estimate: estimate,
        status: ProjectStatus.emAndamento,
        tasks: [],
        userId: userId,
      );
      await _projectService.register(project);
      emit(ProjectRegisterStatus.sucesso);
    } catch (e, s) {
      log('Erro ao salvar projeto', error: e, stackTrace: s);
      emit(ProjectRegisterStatus.failure);
    }
  }
}
