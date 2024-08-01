import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/app/core/ui/job_timer_icons_icons.dart';
import 'package:timer/app/entities/project_status.dart';
import 'package:timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:timer/app/modules/project/detail/widgets/project_detail_appbar.dart';
import 'package:timer/app/modules/project/detail/widgets/project_pei_chart.dart';
import 'package:timer/app/modules/project/detail/widgets/project_task_tile.dart';
import 'package:timer/app/view_model/project_model.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key, required this.controller});

  final ProjectDetailController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
        bloc: controller,
        listener: (context, state) {
          if (state.status == ProjectDetailStatus.failure) {
            return AsukaSnackbar.alert('Erro interno').show();
          }
        },
        builder: (context, state) {
          final projectModel = state.projectModel;
          switch (state.status) {
            case ProjectDetailStatus.initial:
              return const Center(
                child: Text('Carregando projeto'),
              );
            case ProjectDetailStatus.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case ProjectDetailStatus.complete:
              return _buildProjectDetail(context, projectModel!);

            case ProjectDetailStatus.failure:
              if (state.projectModel != null) {
                return _buildProjectDetail(context, projectModel!);
              } else {
                return const Text("Erro ao carregar o projeto");
              }
          }
        },
      ),
    );
  }

  Widget _buildProjectDetail(BuildContext context, ProjectModel projectModel) {
    final totalTask = projectModel.tasks.fold<int>(0, (totalvalue, task) {
      return totalvalue += task.duration;
    });
    return CustomScrollView(
      slivers: [
        ProjectDetailAppbar(
          projectModel: projectModel,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: ProjectPeiChart(
                  projectEstimate: projectModel.estimate,
                  totalTask: totalTask,
                ),
              ),
              ...projectModel.tasks
                  .map(
                    (task) => ProjectTaskTile(task:task ,),
                  )
                  .toList(),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Visibility(
                visible: projectModel.status!=ProjectStatus.finalizado,
                child: ElevatedButton.icon(
                  onPressed: () {controller.finishProject();},
                  label: const Text('Finalizar Projeto'),
                  icon: const Icon(JobTimerIcons.ok_circled2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
