import 'package:timer/app/entities/project_status.dart';
import 'package:timer/app/view_model/Project_task_model.dart';

class ProjectModel {
  ProjectModel({
    this.id,
    required this.name,
    required this.estimate,
    required this.status,
    required this.tasks,
    required this.userId,
  });
  final int? id;
  final String name;
  final int estimate;
  final ProjectStatus status;
  final String userId;

  final List<ProjectTaskModel> tasks;
}
