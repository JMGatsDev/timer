import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/app/core/ui/button_with_loader.dart';
import 'package:timer/app/modules/project/register/controller/project_register_controller.dart';
import 'package:validatorless/validatorless.dart';

class ProjectRegisterPage extends StatefulWidget {
  const ProjectRegisterPage({super.key, required this.controller});

  final ProjectRegisterController controller;

  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _estimateEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _estimateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        switch (state) {
          case ProjectRegisterStatus.sucesso:
            AsukaSnackbar.success('Projeto criado com sucesso').show();
            Navigator.pop(context);
            break;
          case ProjectRegisterStatus.failure:
            AsukaSnackbar.alert('Erro ao salvar projeto').show();
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Criar Novo Projeto',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Nome do projeto'),
                  ),
                  validator: Validatorless.required('Nome Obrigatório'),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                TextFormField(
                  controller: _estimateEC,
                  decoration: const InputDecoration(
                    label: Text('Estimativa de horas'),
                  ),
                  keyboardType: TextInputType.number,
                  validator: Validatorless.multiple(
                    [
                      Validatorless.required('Estiamtiva Obrigatória'),
                      Validatorless.number('Permitido somente números'),
                    ],
                  ),
                ),
                 SizedBox(
                  height: screenSize.height * 0.01,
                ),
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.height * 0.06,
                  child: ButtonWithLoader<ProjectRegisterController,ProjectRegisterStatus>(
                    bloc: widget.controller,
            
                    selector: (state) => state == ProjectRegisterStatus.loading,
                    label: ('Salvar'),
                    onPressed: () async {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        final name = _nameEC.text;
                        final estimate = int.parse(_estimateEC.text);

                        await widget.controller.register(name, estimate);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
