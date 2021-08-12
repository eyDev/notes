import 'package:eydev_notes/src/data/Constants.dart';
import 'package:eydev_notes/src/data/NotesBloc.dart';
import 'package:eydev_notes/src/model/NoteModel.dart';
import 'package:eydev_notes/src/widgets/DeleteDialog.dart';
import 'package:eydev_notes/src/widgets/SnackBarError.dart';
import 'package:flutter/material.dart';

class NoteDetailPage extends StatefulWidget {
  final int? id;
  final String title;
  final String description;
  final Color color;
  final DateTime createdTime;

  const NoteDetailPage({
    Key? key,
    this.id,
    this.title = '',
    this.description = '',
    this.color = const Color(0xFFAED581),
    required this.createdTime,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late final String _date;
  late Color _selectedColor;
  final Constants _constants = Constants();
  final NotesBloc db = NotesBloc();

  @override
  void initState() {
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;
    _date = '${widget.createdTime.day} / ${widget.createdTime.month} / ${widget.createdTime.year}';
    _selectedColor = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(_date),
      body: _body(),
      bottomNavigationBar: _colorPicker(),
    );
  }

  AppBar _appbar(String date) => AppBar(
        title: Text(date),
        centerTitle: true,
        actions: [
          widget.id != null ? IconButton(onPressed: () => _delete(), icon: Icon(Icons.delete)) : Container(),
          IconButton(onPressed: () => _save(), icon: Icon(Icons.save))
        ],
      );

  Widget _body() => Column(
        children: [
          buildTitle(),
          buildDescription(),
        ],
      );

  Widget buildTitle() => TextFormField(
        controller: _titleController,
        maxLines: 2,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          border: InputBorder.none,
          hintText: 'Título',
          hintStyle: TextStyle(color: Colors.white70),
        ),
      );

  Widget buildDescription() => Expanded(
        child: TextFormField(
          controller: _descriptionController,
          maxLines: null,
          style: TextStyle(color: Colors.white60, fontSize: 20),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            border: InputBorder.none,
            hintText: 'Descripción...',
            hintStyle: TextStyle(color: Colors.white60),
          ),
        ),
      );

  Widget _colorPicker() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _constants.colors.map((color) => _buttonColor(color)).toList(),
        ),
      );

  Widget _buttonColor(Color color) => FloatingActionButton(
        heroTag: UniqueKey(),
        elevation: 0,
        mini: true,
        backgroundColor: Colors.transparent,
        onPressed: () => setState(() => _selectedColor = color),
        child: Container(
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 3.5, color: color),
            color: color == _selectedColor ? color : Colors.transparent,
          ),
          width: (MediaQuery.of(context).size.width - 40 - 175) / 5,
          height: (MediaQuery.of(context).size.width - 40 - 175) / 5,
        ),
      );

  _delete() {
    showDialog(
      context: context,
      builder: (BuildContext context) => DeleteDialog(
        id: widget.id,
        title: widget.title,
      ),
    );
  }

  _save() {
    if (_titleController.text != '' && _descriptionController.text != '') {
      widget.id == null
          ? db.ntNewNote(NoteModel(
              title: _titleController.text,
              description: _descriptionController.text,
              color: _selectedColor,
              createdTime: DateTime.now(),
            ))
          : db.ntUpdateNote(NoteModel(
              id: widget.id,
              title: _titleController.text,
              description: _descriptionController.text,
              color: _selectedColor,
              createdTime: DateTime.now(),
            ));
      Navigator.pop(context);
      showInSnackBar(context, 'Guardado!', Colors.greenAccent);
    } else {
      showInSnackBar(context, 'Complete los espacios en blanco', Colors.redAccent);
    }
  }
}
