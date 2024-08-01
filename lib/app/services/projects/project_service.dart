import 'package:timer/app/entities/project_status.dart';
import 'package:timer/app/view_model/project_model.dart';
import 'package:timer/app/view_model/project_task_model.dart';


abstract interface class ProjectService {
  Future<void> register(ProjectModel projectModel);
  Future<List<ProjectModel>> findByStatus(ProjectStatus status);
  Future<ProjectModel> findById(int projectId);

  Future<ProjectModel> addTask(int projectId, ProjectTaskModel task);
  Future<void> finish(int projectId);
}
