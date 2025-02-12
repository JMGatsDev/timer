import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/app/modules/home/widgets/Header_project_menu.dart';
import 'package:timer/app/modules/home/widgets/controller/home_controller.dart';
import 'package:timer/app/modules/home/widgets/project_title.dart';
import 'package:timer/app/view_model/project_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.controller});

  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      bloc: controller,
      listener: (context, state) {
        if (state.status == HomeStatus.failure) {
          AsukaSnackbar.alert('Erro ao buscar projetos');
        }
      },
      child: Scaffold(
        drawer: const Drawer(
          child: SafeArea(
            child: ListTile(
              title: Text('Sair'),
            ),
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Projetos'),
                expandedHeight: 100,
                toolbarHeight: 100,
                centerTitle: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: HeaderProjectMenu(controller: controller),
                pinned: true,
              ),
              BlocSelector<HomeController, HomeState, bool>(
                bloc: controller,
                selector: (state) => state.status == HomeStatus.loading,
                builder: (context, showLoading) {
                  return SliverVisibility(
                    visible: showLoading,
                    sliver: const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    ),
                  );
                },
              ),
              BlocSelector<HomeController, HomeState, List<ProjectModel>>(
                bloc: controller,
                selector: (state) {
                  return state.projects;
                },
                builder: (context, projects) {
                  return SliverList(
                      delegate: SliverChildListDelegate(projects
                          .map(
                            (project) => ProjectTitle(projectModel:project),
                          )
                          .toList()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
