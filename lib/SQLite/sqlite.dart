import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../JsonModel/note_models.dart';
import '../JsonModel/user_models.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';

class DatabaseHelper {
  final databaseName = "notes.db";

  // Table creation queries
  String noteTable =
      "CREATE TABLE notes (noteId INTEGER PRIMARY KEY AUTOINCREMENT, noteTitle TEXT NOT NULL, noteContent TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";

  String usersTable =
      "CREATE TABLE users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usrEmail TEXT UNIQUE, usrPassword TEXT NOT NULL)";

  Future<Database> initDB() async {
    try {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, databaseName);

      // Log the database path for debugging
      log('Database Path: $path');

      return openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(usersTable);
          await db.execute(noteTable);
          log('Database and tables created successfully');
        },
      );
    } catch (e) {
      log('Error initializing database: $e');
      rethrow;
    }
  }

  // Login Method
  Future<bool> login(String email, String password) async {
    final Database db = await initDB();
    var result = await db.query(
      'users',
      where: 'usrEmail = ? AND usrPassword = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty;
  }

  // Signup Method
  Future<int> signup(Users user) async {
    final Database db = await initDB();
    return db.insert('users', user.toMap());
  }

  // Search Notes
  Future<List<NoteModel>> searchNotes(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult = await db.rawQuery(
      "SELECT * FROM notes WHERE noteTitle LIKE ?",
      ["%$keyword%"],
    );
    return searchResult.map((e) => NoteModel.fromMap(e)).toList();
  }

  // CRUD Methods for Notes

  // Create Note
  Future<int> createNote(NoteModel note) async {
    final Database db = await initDB();
    return db.insert('notes', note.toMap());
  }

  // Get Notes
  Future<List<NoteModel>> getNotes() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  // Delete Note
  Future<int> deleteNote(int id) async {
    final Database db = await initDB();
    return db.delete('notes', where: 'noteId = ?', whereArgs: [id]);
  }

  // Update Note
  Future<int> updateNote(String title, String content, int noteId) async {
    final Database db = await initDB();
    return db.rawUpdate(
      'UPDATE notes SET noteTitle = ?, noteContent = ? WHERE noteId = ?',
      [title, content, noteId],
    );
  }

  // Export all users to a file
  Future<String> exportUsersToFile() async {
    final dbInstance = await initDB();
    final result = await dbInstance.query('users');
    final users = result.map((e) => Users.fromMap(e)).toList();

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/users.txt');

    final userStrings = users
        .map((user) {
          return 'ID: ${user.usrId}, Name: ${user.usrName}, Email: ${user.usrEmail}, Password: ${user.usrPassword}';
        })
        .join('\n');

    await file.writeAsString(userStrings);
    return file.path;
  }

  Future<String> exportDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    final directory = await getApplicationDocumentsDirectory();
    final exportPath = join(directory.path, 'exported_$databaseName');

    final dbFile = File(path);
    final exportFile = File(exportPath);

    if (await dbFile.exists()) {
      await dbFile.copy(exportFile.path);
      return exportFile.path;
    } else {
      throw Exception('Database file does not exist');
    }
  }

  Future<void> insertDummyData() async {
    try {
      final db = await initDB();

      // Insert dummy user data
      await db.insert('users', {
        'usrName': 'John Doe',
        'usrEmail': 'john.doe@example.com',
        'usrPassword': 'password123',
      });

      // Insert dummy note data
      await db.insert('notes', {
        'noteTitle': 'Sample Note',
        'noteContent': 'This is a sample note.',
        'createdAt': DateTime.now().toIso8601String(),
      });

      log('Dummy data inserted successfully');
    } catch (e) {
      log('Error inserting dummy data: $e');
    }
  }
}
