import 'package:timer/app/entities/project.dart';
import 'package:timer/app/entities/project_status.dart';
import 'package:timer/app/repositories/projects/project_repository.dart';
import 'package:timer/app/view_model/project_model.dart';

import './project_service.dart';

class ProjectServiceImpl implements ProjectService {
  ProjectServiceImpl({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  final ProjectRepository _projectRepository;

  @override
  Future<void> register(ProjectModel project_model) async {
    final project = Project()
      ..id = project_model.id! 
      ..name = project_model.name
      ..status = project_model.status
      ..estimate = project_model.estimate
      ..userId = project_model.userId;
    await _projectRepository.register(project);
  }

  @override
  Future<List<ProjectModel>> findByStatus(ProjectStatus status) async {
    final projects = await _projectRepository.findByStatus(status);
    return projects.map(ProjectModel.fromEntity).toList();
  }
}
