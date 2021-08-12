import 'package:eydev_notes/src/model/NoteModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  static Database? _database;
  static final NotesDatabase db = NotesDatabase._();

  NotesDatabase._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future _initDB() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'NotesDB.db');
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Notes('
          ' id INTEGER PRIMARY KEY,'
          ' title TEXT NOT NULL,'
          ' description TEXT NOT NULL,'
          ' color TEXT NOT NULL,'
          ' createdTime TEXT NOT NULL'
          ')');
    });
  }

  Future<int> newNote(NoteModel note) async {
    final Database db = await database;
    final int res = await db.insert('Notes', note.toJson());
    return res;
  }

  Future<List<NoteModel>> getNotes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> res = await db.query('Notes');

    List<NoteModel> list = res.isNotEmpty ? res.map((s) => NoteModel.fromJson(s)).toList() : [];
    return list;
  }

  Future<int> updateNote(NoteModel note) async {
    final Database db = await database;
    final int res = await db.update('Notes', note.toJson(), where: 'id = ?', whereArgs: [note.id]);
    return res;
  }

  Future<int> deleteNote(int id) async {
    final Database db = await database;
    final int res = await db.delete('Notes', where: 'id=?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteALlNotes() async {
    final Database db = await database;
    final int res = await db.rawDelete("DELETE FROM Notes");
    return res;
  }

  Future<List<NoteModel>> searchNotes(query) async {
    final Database db = await database;
    final List<Map<String, dynamic>> res = await db.query(
      'Notes',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ["%$query%", "%$query%"],
    );

    List<NoteModel> list = res.isNotEmpty ? res.map((s) => NoteModel.fromJson(s)).toList() : [];
    return list;
  }
}
