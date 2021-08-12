import 'package:eydev_notes/src/model/NoteModel.dart';
import 'package:flutter/material.dart';

class NoteCardWidget extends StatelessWidget {
  NoteCardWidget({Key? key, required this.note}) : super(key: key);
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    final DateTime noteDate = note.createdTime;
    final String time = '${noteDate.day} / ${noteDate.month} / ${noteDate.year}';
    return Card(
      color: note.color,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            SizedBox(height: 4),
            Text(
              note.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
