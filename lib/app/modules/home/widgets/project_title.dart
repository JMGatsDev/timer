import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/core/ui/job_timer_icons_icons.dart';
import 'package:timer/app/modules/home/widgets/controller/home_controller.dart';
import 'package:timer/app/view_model/project_model.dart';

class ProjectTitle extends StatelessWidget {
  const ProjectTitle({super.key, required this.projectModel});

  final ProjectModel projectModel;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
       onTap: ()  async {
        await Modular.to.pushNamed('/project/detail',arguments: projectModel);
        Modular.get<HomeController>().updateList();
      },
      child: Container(
        constraints: BoxConstraints(maxHeight: screenSize.height * 0.11),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!, width: 4),
        ),
        child: Column(
          children: [
            _ProjectName(projectModel: projectModel),
            Expanded(child: _ProjectProgress(projectModel: projectModel)),
          ],
        ),
      ),
    );
  }
}

class _ProjectProgress extends StatelessWidget {
  const _ProjectProgress({required this.projectModel});
  final ProjectModel projectModel;

  @override
  Widget build(BuildContext context) {
    final totalTasks = projectModel.tasks
        .fold<int>(0, (previousValue, task) => previousValue += task.duration);
    double percent = 0.0;
    if (totalTasks > 0) {
      percent = totalTasks / projectModel.estimate;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
              child: LinearProgressIndicator(
            value: percent,
            backgroundColor: Colors.grey[400],
            color: Theme.of(context).primaryColor,
          )),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('${projectModel.estimate}'),
          )
        ],
      ),
    );
  }
}

class _ProjectName extends StatelessWidget {
  const _ProjectName({required this.projectModel});
  final ProjectModel projectModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(projectModel.name),
          Icon(
            JobTimerIcons.angle_double_right,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
