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
}
