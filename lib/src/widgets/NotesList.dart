import 'package:eydev_notes/src/data/Constants.dart';
import 'package:eydev_notes/src/pages/NoteDetailPage.dart';
import 'package:eydev_notes/src/widgets/NoteWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key, required this.snapshot}) : super(key: key);
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final Constants _constants = Constants();
    if (!snapshot.hasData) {
      return Center(
          child: CircularProgressIndicator(
        color: _constants.primaryColor,
      ));
    }
    final notes = snapshot.data;
    if (notes!.length == 0) {
      return Center(
        child: Image.asset(
          'assets/empty.png',
          width: MediaQuery.of(context).size.width / 2,
        ),
      );
    }
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8),
      itemCount: notes.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final note = notes[index];
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteDetailPage(
              id: note.id,
              title: note.title,
              description: note.description,
              color: note.color,
              createdTime: note.createdTime,
            ),
          )),
          child: NoteCardWidget(note: note),
        );
      },
    );
  }
}
