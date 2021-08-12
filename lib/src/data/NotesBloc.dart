import 'dart:async';

import 'package:eydev_notes/src/data/NotesDatabase.dart';
import 'package:eydev_notes/src/model/NoteModel.dart';

class NotesBloc {
  static final NotesBloc ntbloc = new NotesBloc._internal();

  factory NotesBloc() {
    return ntbloc;
  }

  NotesBloc._internal() {
    ntGetNotes();
  }

  final _notesController = StreamController<List<NoteModel>>.broadcast();

  Stream<List<NoteModel>> get notesStream => _notesController.stream;

  dispose() {
    _notesController.close();
  }

  ntGetNotes() async {
    _notesController.sink.add(await NotesDatabase.db.getNotes());
  }

  ntNewNote(NoteModel note) async {
    await NotesDatabase.db.newNote(note);
    ntGetNotes();
  }

  ntUpdateNote(NoteModel note) async {
    await NotesDatabase.db.updateNote(note);
    ntGetNotes();
  }

  ntDeleteNote(int id) async {
    await NotesDatabase.db.deleteNote(id);
    ntGetNotes();
  }

  ntDeleteAllNotes() async {
    NotesDatabase.db.deleteALlNotes();
    ntGetNotes();
  }
}
