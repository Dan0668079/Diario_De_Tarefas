import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/controllers/talk_controller.dart';
import 'package:teste/controllers/user_controller.dart';
import 'package:teste/src/ui/components/drawer_todo_list_form.dart';
import 'package:teste/src/ui/theme/text_style_widget.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late final userController = Provider.of<UserController>(
      context,
      listen: false,
    );
    late final talkController =
        Provider.of<TalkController>(context, listen: true);

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userController.model.nome),
              accountEmail: Text(userController.user!.email!),
            ),
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: (talkController.selectedModel != null)
                  ? Text("Tarefa ${talkController.selectedModel!.title}",
                      style: TextStyles.titleHomeAppBar)
                  : Text("Nova Tarefa", style: TextStyles.titleHomeAppBar),
            ),
            const Padding(
                padding: EdgeInsets.only(
                  top: 9.0,
                ),
                child: DrawerTodoListForm())
          ],
        ),
      ),
    );
  }
}
