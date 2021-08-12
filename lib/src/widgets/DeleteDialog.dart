import 'package:eydev_notes/src/data/Constants.dart';
import 'package:eydev_notes/src/data/NotesBloc.dart';
import 'package:eydev_notes/src/widgets/SnackBarError.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatefulWidget {
  final int? id;
  final String? title;

  const DeleteDialog({
    Key? key,
    this.id,
    this.title,
  }) : super(key: key);

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  final Constants _constants = Constants();
  final NotesBloc db = NotesBloc();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF1D2330),
      elevation: 1,
      title: Text(
        'Eliminar ${widget.id != null ? 'Nota' : 'Notas'}',
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      content: Text(
        '¿Está seguro que desea eliminar ${widget.title != null ? widget.title!.toUpperCase() : 'todas las notas guardadas'}?',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancelar',
            style: TextStyle(color: _constants.primaryColor),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.id != null ? db.ntDeleteNote(widget.id!) : db.ntDeleteAllNotes();
            Navigator.pop(context);
            if (widget.id != null) Navigator.pop(context);
            showInSnackBar(context, 'Eliminado!', Colors.greenAccent);
          },
          child: Text(
            'Aceptar',
            style: TextStyle(color: _constants.primaryColor),
          ),
        ),
      ],
    );
  }
}
