import 'package:get/get.dart';
import 'package:notes_app/models/NotelyModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Databaseservices extends GetxService {
  static Database? _database;


  Future<Databaseservices> init() async {
     sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
    _database = await openDatabase(
      join(await getDatabasesPath(), "notes.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(''' 
          CREATE TABLE notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          preview TEXT,
          date TEXT,
          color TEXT)
          ''');
      },
    );
    return this;
  }

  //insert notes
  Future<int> insertNote(Notelymodel note) async {
    return await _database!.insert('notes', note.toJson());
  }

  //get notes
  Future<List<Notelymodel>> getNotes() async {
    List<Map<String, dynamic>> notes = await _database!.query('notes');

    return notes.map((notes) => Notelymodel.fromJson(notes)).toList();
  }

  //delete notes
  Future<void> deleteNotes(int id) async {
    await _database!.delete('notes', where: 'id=?', whereArgs: [id]);
  }

  //update notes
  Future<void> updateNotes(Notelymodel note) async {
    await _database!.update(
      'notes',
      note.toJson(),
      where: 'id=?',
      whereArgs: [note.id],
    );
  }
}
