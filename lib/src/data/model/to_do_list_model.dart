import 'dart:convert';

import 'package:flutter/material.dart';

class ToDoListModel {
  String id;
  CircleAvatar icone;
  String title;
  String descricao;
  DateTime date;
  TimeOfDay time;

  ToDoListModel({
    required this.id,
    required this.icone,
    required this.title,
    required this.descricao,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'icone': icone.toString(),
      'title': title,
      'descricao': descricao,
      'date': date.millisecondsSinceEpoch,
      'time': time.toString(),
    };
  }

  factory ToDoListModel.fromMap(Map<String, dynamic> map) {
    return ToDoListModel(
      id: map['id'] ?? '',
      icone: CircleAvatar(),
      title: map['title'] ?? '',
      descricao: map['descricao'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      time: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDoListModel.fromJson(String source) => ToDoListModel.fromMap(json.decode(source));
}
