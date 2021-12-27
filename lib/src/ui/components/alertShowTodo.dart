import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teste/src/data/data.dart';
import 'package:intl/intl.dart';
import 'package:teste/src/data/model/model.dart';
import 'package:teste/src/data/model/toDoList_model.dart';

double screenHeight = 0;
double screenWidth = 0;

alertShowTodo(BuildContext context, ToDoListModel tr) {
  screenHeight = MediaQuery.of(context).size.height;

  screenWidth = MediaQuery.of(context).size.width;

  showDialog(
    barrierColor: Colors.white70,
    barrierDismissible: false,
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
      content: details(context, tr),
      actions: [
        Container(
          margin: const EdgeInsets.only(bottom: 30.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "OK",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(100, 50)),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFF00E676)),
            ),
          ),
        ),
      ],
    ),
  );
}

details(BuildContext context, ToDoListModel tr) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    height: screenHeight * 0.55,
    width: screenWidth * 0.90,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.grey[100],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              tr.icone,
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Text(
                tr.title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('dd MMM').format(tr.date),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    tr.time.format(context),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Descrição',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                tr.descricao,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
