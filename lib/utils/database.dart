import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:su_task7/utils/note.dart';

class DatabaseHelper {

  static DatabaseHelper? _databaseHelper;    // Singleton DatabaseHelper
  static Database? _database;                // Singleton Database

  String noteTable = 'note_table';
  String colUid = 'uid';
  String colPlatform = 'platform';
  String colUsername = 'username';
  String colPassword = 'password';
  String colTime = 'time';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database?> get database async {

    _database ??= await initializeDatabase();
    return _database;
  }
//initialisation of database by defining path of memory
  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $noteTable( $colTime TEXT PRIMARY KEY, $colPlatform TEXT, '
        '$colUsername TEXT, $colPassword TEXT,$colUid TEXT  )');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>?> getNoteMapList() async {
    Database? db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db?.query(noteTable,);
    return result;
  }



  // Insert Operation: Insert a Note object to database
  Future<int?> insertNote(Note note) async {
    Database? db = await this.database;
    var result = await db?.insert(noteTable, note.toMap());
    return result;
  }



  // Update Operation: Update a Note object and save it to database
  Future<int?> updateNote(Note note) async {
    var db = await this.database;
    var result = await db?.update(noteTable, note.toMap(), where: '$colTime = ?', whereArgs: [note.time]);
    return result;
  }




  // Delete Operation: Delete a Note object from database
  Future<int?> deleteNote(String? time) async {
    var db = await this.database;
    int? result = await db?.rawDelete('DELETE FROM $noteTable WHERE $colTime = $time');
    return result;
  }




  // Get number of Note objects in database
  Future<int?> getCount() async {
    Database? db = await this.database;
    List<Map<String, Object?>>? x = await db?.rawQuery('SELECT COUNT (*) from $noteTable');
    int? result = Sqflite.firstIntValue(x!);
    return result;
  }



  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Note>> getNoteList() async {

    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int? count = noteMapList?.length;         // Count the number of map entries in db table

    List<Note> noteList = [];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count!; i++) {
      noteList.add(Note.fromMapObject(noteMapList![i]));
    }

    return noteList;
  }


}