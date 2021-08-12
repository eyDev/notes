import 'package:eydev_notes/src/data/NotesDatabase.dart';
import 'package:eydev_notes/src/widgets/NotesList.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  DataSearch()
      : super(
          searchFieldLabel: 'Buscar notas',
          keyboardType: TextInputType.text,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(future: NotesDatabase.db.searchNotes(query), builder: _notesResult);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(future: NotesDatabase.db.searchNotes(query), builder: _notesResult);
  }

  Widget _notesResult(BuildContext context, AsyncSnapshot snapshot) => NotesList(snapshot: snapshot);
}
