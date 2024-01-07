import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import '../models/auth.dart';
import '../models/patient_notification.dart';
import '../models/pending_response.dart';

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
              firebaseToken TEXT,
              lastAccess TEXT
            )
          ''');

        await db.execute('''
              CREATE TABLE IF NOT EXISTS pending_response (
                id INTEGER PRIMARY KEY autoincrement,
                title TEXT,
                date TEXT,
                period TEXT,
                ansToday BOOLEAN
              )              
            ''');
      },
    );
  }

  Future<void> insertAuth(token, email, confirmed, role, idPatient,
      institutionId, firebaseToken, lastAccess) async {
    final db = await DatabaseController().db;
    try {
      final idResultbd = await db.insert(
        'auth',
        {
          'token': token,
          'email': email,
          'confirmed': confirmed ? 1 : 0,
          'role': role,
          'idPatient': idPatient,
          'institutionId': institutionId ?? '',
          'firebaseToken': firebaseToken,
          'lastAccess': lastAccess.toString(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      if (kDebugMode) {
        print(idResultbd);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<Auth> getAuths() async {
    final db = await DatabaseController().db;

    final List<Map<String, dynamic>> maps = await db.query('auth');

    List<Auth> auths = [];
    for (int i = 0; i < maps.length; i++) {
      auths.add(
        Auth(
          token: maps[i]['token']!,
          email: maps[i]['email']!,
          confirmed: maps[i]['confirmed']! == 1 ? true : false,
          role: maps[i]['role']!,
          idPatient: maps[i]['idPatient']! as int,
          institutionId: int.tryParse(maps[i]['institutionId']!.toString()),
          firebaseToken: maps[i]['firebaseToken']!,
          lastAccess: maps[i]['lastAccess']!,
        ),
      );
    }

    return auths.first;
  }

  Future<int?> getIdPatient() async {
    final db = await DatabaseController().db;
    // List<Map> result = await db.rawQuery('SELECT * FROM "auth"');
    final List<Map<String, dynamic>> result = await db.query('auth');

    int idPatient = result.first['idPatient'];
    return idPatient;
  }

  Future<String?> getToken() async {
    final db = await DatabaseController().db;
    final List<Map<String, dynamic>> result = await db.query('auth');

    String token = result.first['token'];
    if (kDebugMode) {
      print('id patient: $token');
    }
    return token;
  }

  Future<String?> getLastAccess() async {
    final db = await DatabaseController().db;
    final List<Map<String, dynamic>> result = await db.query('auth');

    String? lastAccess = result.isNotEmpty
        ? result.first['lastAccess']
        : DateFormat("yyyy-MM-dd").format(DateTime.now());

    if (kDebugMode) {
      print('lastAccess: $lastAccess');
    }
    return lastAccess;
  }

  Future<void> updateAuth(lastAccess, token) async {
    final db = await DatabaseController().db;
    try {
      final resultupdate = await db.update(
        'auth',
        {
          'lastAccess': lastAccess.toString(),
        },
        where: 'token = ?',
        whereArgs: [token],
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> insertPendingResponse(title, date, period, ansToday) async {
    final db = await DatabaseController().db;
    try {
      final resultInsert = await db.insert(
        'pending_response',
        {
          'title': title,
          'date': date,
          'period': period,
          'ansToday': ansToday ? 1 : 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      if (kDebugMode) {
        print(resultInsert);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> deletePendingResponse(int id) async {
    final db = await DatabaseController().db;

    await db.delete(
      'pending_response',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<PendingResponse>> getPendingResponse() async {
    final db = await DatabaseController().db;
    final List<Map<String, dynamic>> result =
        await db.query('pending_response');

    List<PendingResponse> pending = [];
    for (int i = 0; i < result.length; i++) {
      pending.add(
        PendingResponse(
          id: result[i]['id'],
          title: result[i]['title'],
          date: result[i]['date'],
          period: result[i]['period'],
        ),
      );
    }

    return pending;
  }

  Future<void> insertNotificacao(title, body, lida) async {
    final db = await DatabaseController().db;
    await db.insert('notificacao', {
      'title': title,
      'body': body,
      'lida': lida,
    });
  }

  Future<List<PatientNotification>> getNotificacao() async {
    final db = await DatabaseController().db;

    List<Map<String, dynamic>> result = await db.query(
      'notificacao',
    );
    List<PatientNotification> notis = [];
    for (int i = 0; i < result.length; i++) {
      notis.add(
        PatientNotification(
          title: result[i]['title'],
          body: result[i]['body'],
          lida: result[i]['lida'],
          id: result[i]['id'],
        ),
      );
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
