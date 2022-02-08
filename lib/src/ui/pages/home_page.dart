import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/controllers/talk_controller.dart';
import 'package:teste/controllers/user_controller.dart';
import 'package:teste/src/ui/components/drawer_widget.dart';
import '../../src.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final globalKey = GlobalKey<ScaffoldState>();

class _MyHomePageState extends State<MyHomePage> {
  // final List<ToDoListModel> toDoList = [];

  late final UserController userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  late final talkController = Provider.of<TalkController>(
    context,
    listen: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEEEE),
        centerTitle: true,
        title: Text('Tarefas', style: TextStyles.titleHomeAppBar),
        actions: [
          IconButton(
            alignment: Alignment.bottomLeft,
            onPressed: () async {
              await userController.logout();
            },
            icon: const Icon(
              Icons.exit_to_app_outlined,
            ),
          )
        ],
      ),
      endDrawer: DrawerWidget(),
      body: SizedBox(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFFFFFFF),
              child: Column(
                children: [
                  ToDoListComponent(talkController.tasksList),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          talkController.selectedModel = null;
          globalKey.currentState!.openEndDrawer();
        },
        backgroundColor: const Color(0xFF00E676),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
