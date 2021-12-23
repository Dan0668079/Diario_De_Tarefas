import 'dart:math';
import 'package:flutter/material.dart';
import '../../src.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TransactionModel> _transactions = [];

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
          backgroundColor: const Color(0xFFEEEEEE),
          centerTitle: true,
          title: const Text('Tarefas'),
          actions: const []),
      endDrawer: Drawer(
        child: Column(
          children: [
            Container(
               margin: const EdgeInsets.only(right:160, top:100),
              child: const Text(
                "Nova Tarefa",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: TransactionFormComponent(_addTransaction),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFFFFFFF),
          child: Column(
            children: [
              TransactionListComponent(_transactions),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => globalKey.currentState!.openEndDrawer(),
        backgroundColor: const Color(0xFF00E676),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _addTransaction(CircleAvatar icone, String title, String descricao, DateTime date,
      TimeOfDay time) {
    final newTransaction = TransactionModel(
      id: Random().nextDouble().toString(),
      icone: icone,
      title: title,
      descricao: descricao,
      date: date,
      time: time,
    );

    setState(
      () {
        _transactions.add(newTransaction);
      },
    );
  }
}
