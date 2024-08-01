import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/services/projects/project_service.dart';
import 'package:timer/app/view_model/project_model.dart';

part 'project_detail_state.dart';

class ProjectDetailController extends Cubit<ProjectDetailState> {
  ProjectDetailController()
      : _projectService = Modular.get<ProjectService>(),
        super(const ProjectDetailState.intial());
          final ProjectService _projectService;


  void setProject(ProjectModel project) {
    emit(state.copyWith(
        projectModel: project, status: ProjectDetailStatus.complete));
  }

  void updateProject() async {
    final project = await _projectService.findById(state.projectModel!.id!);
    emit(state.copyWith(
      projectModel: project,
      status: ProjectDetailStatus.complete,
    ));
  }

  Future<void> finishProject() async {
    try {
      emit(state.copyWith(status: ProjectDetailStatus.loading));
      final projectId = state.projectModel!.id!;
      await _projectService.finish(projectId);

      updateProject();
    } catch (e) {
      emit(state.copyWith(status: ProjectDetailStatus.failure));
    }
  

  // void deleteTask(ProjectTaskModel task) async {
  //   try {
  //     emit(state.copyWith(status: ProjectDetailStatus.loading));
  //     final taskId = task.id;
  //     await _projectService.deleteTask(taskId);
  //     updateProject();
  //   } catch (e) {
  //     emit(state.copyWith(status: ProjectDetailStatus.failure));
  //   }
  // }
}
}