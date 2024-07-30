import 'package:timer/app/view_model/project_model.dart';

abstract interface class ProjectService {
Future<void> register(ProjectModel project_model);

}