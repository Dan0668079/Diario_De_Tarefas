import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teste/controllers/talk_controller.dart';
import 'package:teste/controllers/user_controller.dart';
import 'package:teste/src/ui/components/drawer_todo_list_form.dart';
import 'package:teste/src/ui/pages/login_page.dart';
import '../../src.dart';
import 'drawer_edit_todo_list_form.dart';

class ToDoListComponent extends StatefulWidget {
  final List<ToDoListModel> toDoList;

  const ToDoListComponent(this.toDoList, {Key? key}) : super(key: key);

  @override
  State<ToDoListComponent> createState() => _ToDoListComponentState();
}

class _ToDoListComponentState extends State<ToDoListComponent> {
  final tasksList = <ToDoListModel>[];
  late final talkController = Provider.of<TalkController>(
    context,
    listen: false,
  );

  get time => null;

  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 520,
      // child: widget.toDoList.isEmpty
      child: talkController.tasksList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Agendar tarefas",
                      style: GoogleFonts.blackOpsOne(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFFFB6C34),
                        ),
                      ),
                      // style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: talkController.tasksList.length,
                itemBuilder: (ctx, index) {
                  final tr = talkController.tasksList[index];

                  return GestureDetector(
                      child: Card(
                        elevation: 10,
                        margin: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 25,
                        ),
                        child: SizedBox(
                          width: screenWidth * 0.95,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 23,
                                child: tr.icone,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        tr.title,
                                        style: TextStyles.trTitleComponent,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            DateFormat('dd MMM').format(tr.date),
                                            style: TextStyles.dateFormatComponent,
                                          ),
                                          Text(
                                            tr.time.format(
                                              context,
                                            ),
                                            style: TextStyles.trTimeComponent,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(icon: const Icon(Icons.delete), onPressed: () async {}),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        talkController.selectedModel = tr;
                        if (talkController.selectedModel != null) {
                          talkController.titleController.text = talkController.selectedModel!.title;
                          talkController.descricaoController.text = talkController.selectedModel!.descricao;
                          int indice = talkController.avatarList.indexOf(talkController.selectedModel!.icone);
                          talkController.selectIndex = indice;
                          talkController.selectedIcon = talkController.selectedModel!.icone;
                        }
                        globalKey.currentState!.openEndDrawer();
                      });
                },
              ),
            ),
    );
  }
}
