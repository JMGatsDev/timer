import 'package:flutter/material.dart';
import 'package:timer/app/core/ui/job_timer_icons_icons.dart';
import 'package:timer/app/modules/project/detail/widgets/project_detail_appbar.dart';
import 'package:timer/app/modules/project/detail/widgets/project_pei_chart.dart';
import 'package:timer/app/modules/project/detail/widgets/project_task_tile.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ProjectDetailAppbar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 50),
                  child: ProjectPeiChart(),
                ),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
                const ProjectTaskTile(),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  label: const Text('Finalizar Projeto'),
                  icon: const Icon(JobTimerIcons.ok_circled2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
