import 'package:eydev_notes/src/data/Constants.dart';
import 'package:eydev_notes/src/data/NotesBloc.dart';
import 'package:eydev_notes/src/model/NoteModel.dart';
import 'package:eydev_notes/src/pages/NoteDetailPage.dart';
import 'package:eydev_notes/src/widgets/DeleteDialog.dart';
import 'package:eydev_notes/src/widgets/NotesList.dart';
import 'package:eydev_notes/src/widgets/SearchDelegate.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final Constants _constants = Constants();
  final NotesBloc db = NotesBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  AppBar _appbar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => DeleteDialog(),
        ),
      ),
      title: Text('eydev - Notas'),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => showSearch(
            context: context,
            delegate: DataSearch(),
          ),
        )
      ],
    );
  }

  Widget _body() {
    return StreamBuilder<List<NoteModel>>(
        stream: db.notesStream,
        builder: (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot) {
          return NotesList(snapshot: snapshot);
        });
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: _constants.primaryColor,
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NoteDetailPage(
          createdTime: DateTime.now(),
        ),
      )),
    );
  }
}
