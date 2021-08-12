import 'package:eydev_notes/src/data/Constants.dart';
import 'package:eydev_notes/src/pages/NotesPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Constants _constants = Constants();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: _constants.bgColor,
      debugShowCheckedModeBanner: false,
      title: 'eydev - Notes app',
      home: NotesPage(),
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: _constants.primaryColor,
          selectionColor: _constants.primaryColor,
        ),
        scaffoldBackgroundColor: _constants.bgColor,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
