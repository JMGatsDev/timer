import 'package:isar/isar.dart';
import 'package:timer/app/entities/project_task.dart';

class ProjectTaskModel {
  Id? id;
  String name;
  int duration;
  ProjectTaskModel({
    this.id,
    required this.name,
    required this.duration,
  });

  factory ProjectTaskModel.fromEntity(ProjectTask task) {
    return ProjectTaskModel(
        id: task.id, name: task.name, duration: task.duration);
  }
}
