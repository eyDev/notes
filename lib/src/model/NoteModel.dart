import 'package:flutter/material.dart';

class NoteModel {
  final int? id;
  final String title;
  final String description;
  final Color color;
  final DateTime createdTime;

  NoteModel({
    this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.createdTime,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => new NoteModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        color: Color(int.parse(json['color'], radix: 16)),
        createdTime: DateTime.parse(json['createdTime']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "color": color.toString().split('(0x')[1].split(')')[0],
        "createdTime": createdTime.toString(),
      };
}
