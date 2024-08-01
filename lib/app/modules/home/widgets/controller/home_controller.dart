import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/entities/project_status.dart';
import 'package:timer/app/services/projects/project_service.dart';
import 'package:timer/app/view_model/project_model.dart';
part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController()
      : _projectService = Modular.get<ProjectService>(),
        super(HomeState.initial());

  final ProjectService _projectService;

  Future<void> loadProjects() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final projects = await _projectService.findByStatus(state.projectFilter);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } catch (e, s) {
      log('Erro ao buscar projetos', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    emit(state.copyWith(status: HomeStatus.loading, projects: []));
    final projects = await _projectService.findByStatus(status);
    emit(
      state.copyWith(
          status: HomeStatus.complete,
          projects: projects,
          projectFilter: status),
    );
  }

  void updateList() => filter(state.projectFilter);
}
