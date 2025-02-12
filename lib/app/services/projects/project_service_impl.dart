import 'package:timer/app/entities/project.dart';
import 'package:timer/app/entities/project_status.dart';
import 'package:timer/app/entities/project_task.dart';
import 'package:timer/app/repositories/projects/project_repository.dart';
import 'package:timer/app/view_model/project_model.dart';

import '../../view_model/project_task_model.dart';
import './project_service.dart';

class ProjectServiceImpl implements ProjectService {
  ProjectServiceImpl({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  final ProjectRepository _projectRepository;

  @override
  Future<void> register(ProjectModel projectModel) async {
    final project = Project()
      ..id = projectModel.id!
      ..name = projectModel.name
      ..status = projectModel.status
      ..estimate = projectModel.estimate
      ..userId = projectModel.userId;
    await _projectRepository.register(project);
  }

  @override
  Future<List<ProjectModel>> findByStatus(ProjectStatus status) async {
    final projects = await _projectRepository.findByStatus(status);
    return projects.map(ProjectModel.fromEntity).toList();
  }

  @override
  Future<ProjectModel> findById(int projectId) async {
    final project = await _projectRepository.findById(projectId);
    return ProjectModel.fromEntity(project);
  }

  @override
  Future<ProjectModel> addTask(int projectId, ProjectTaskModel task) async {
    final projectTask = ProjectTask()
      ..name = task.name
      ..duration = task.duration;

    final project = await _projectRepository.addTask(projectId, projectTask);

    return ProjectModel.fromEntity(project);
  }
  
  @override
  Future<void> finish(int projectId) => _projectRepository.finish(projectId);
}
