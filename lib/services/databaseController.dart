import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';

import '../models/auth.dart';
import '../models/patient_notification.dart';

class DatabaseController with ChangeNotifier {
  static final DatabaseController _instance = DatabaseController.internal();
  factory DatabaseController() => _instance;

  static Database? _db;
  static String _dbName = "database.db";
  DatabaseController.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE notificacao (
            id INTEGER PRIMARY KEY,
            title TEXT,
            body TEXT,
            lida INTEGER
          )
        ''');

        await db.execute('''
            CREATE TABLE IF NOT EXISTS auth (
            token TEXT PRIMARY KEY, 
            email TEXT,
            confirmed BOOLEAN,
            role TEXT,
            idPatient INTEGER,
            institutionId INTEGER,
            firebaseToken TEXT)
          ''');
      },
    );
  }

  Future<void> insertAuth(token, email, confirmed, role, idPatient,
      institutionId, firebaseToken) async {
    final db = await DatabaseController().db;
    try {
      final id_resultBd = await db.insert(
        'auth',
        {
          'token': token,
          'email': email,
          'confirmed': confirmed,
          'role': role,
          'idPatient': idPatient,
          'institutionId': institutionId ?? '',
          'firebaseToken': firebaseToken,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (kDebugMode) {
        print(id_resultBd);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<List<Auth>> getAuth() async {
    final db = await DatabaseController().db;

    List<Map<String, dynamic>> result = await db.query(
      'auth',
    );
    List<Auth> auths = [];
    for (int i = 0; i < result.length; i++) {
      auths.add(
        Auth(
          token: result[i]["token"],
          email: result[i]["email"],
          confirmed: result[i]["confirmed"],
          role: result[i]["role"],
          idPatient: result[i]["idPatient"],
          institutionId: result[i]["institutionId"],
          firebaseToken: result[i]["firebaseToken"],
        ),
      );
    }
    return auths;
  }

  Future<void> insertNotificacao(title, body, lida) async {
    final db = await DatabaseController().db;
    await db
        .insert('notificacao', {'title': title, 'body': body, 'lida': lida});
  }

  Future<List<PatientNotification>> getNotificacao() async {
    final db = await DatabaseController().db;

    List<Map<String, dynamic>> result = await db.query(
      'notificacao',
    );
    List<PatientNotification> notis = [];
    for (int i = 0; i < result.length; i++) {
      notis.add(PatientNotification(
          title: result[i]['title'],
          body: result[i]['body'],
          lida: result[i]['lida'],
          id: result[i]['id']));
    }

    return notis;
  }

  Future<void> deleteNotificacao(int id) async {
    final db = await DatabaseController().db;

    await db.delete(
      'notificacao',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
