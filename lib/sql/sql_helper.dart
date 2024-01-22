import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import 'sql_constants.dart';

class SQLParam<T> {
  final String table;
  final Map<String, Object>? values;
  final List<String>? columns;
  final String? where;
  final List<Object?>? whereArgs;

  SQLParam({
    required this.table,
    this.values,
    this.columns,
    this.where,
    this.whereArgs,
  });
}

class SQLHelper {
  final SQLConstants constants = SQLConstants();
  Future<void> createTables(sql.Database database) async {
    final createBukuQuery = """CREATE TABLE ${constants.table.buku}(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      id_buku TEXT NOT NULL,
      id_user TEXT NOT NULL,
      last_page_seen INTEGER,
      total_pages INTEGER NOT NULL,
      status TEXT DEFAULT "unread"
    )""";
    final createBukuHalamanBintangQuery = """CREATE TABLE ${constants.table.bukuHalamanBintang}(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      id_buku TEXT NOT NULL,
      id_user TEXT NOT NULL,
      halaman INTEGER NOT NULL
    )""";
    final createNotifikasiQuery = """CREATE TABLE ${constants.table.notifikasi}(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      id_user TEXT NOT NULL,
      title TEXT,
      description TEXT,
      imgPath TEXT,
      readAt DATE,
      receivedAt DATE
    )""";
    await database.execute(createBukuQuery);
    await database.execute(createBukuHalamanBintangQuery);
    await database.execute(createNotifikasiQuery);
  }

  Future<sql.Database> db() async {
    final path = join(await sql.getDatabasesPath(), constants.databaseName);
    return sql.openDatabase(
      path,
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<List<Map<String, dynamic>>> read(SQLParam param) async {
    final database = await db();
    final result = database.query(
      param.table,
      columns: param.columns,
      where: param.where,
      whereArgs: param.whereArgs,
    );
    return result;
  }

  Future<int> delelte(SQLParam param) async {
    final database = await db();
    final result = database.delete(
      param.table,
      where: param.where,
      whereArgs: param.whereArgs,
    );
    return result;
  }

  Future<int> update(SQLParam param) async {
    final database = await db();
    final result = database.update(
      param.table,
      param.values!,
      where: param.where,
      whereArgs: param.whereArgs,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
    return result;
  }

  Future<int> insert(SQLParam param) async {
    final database = await db();
    final result = database.insert(
      param.table,
      param.values!,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
    return result;
  }
}

final SQLHelper sqlHelper = SQLHelper();

final buku = {
  "id": "",
  "id_buku": "",
  "id_user": "",
  "last_page_seen": 11,
  "total_pages": 120,
  "status": "undone",
};

final bukuHalamanBintang = {
  "id": "",
  "id_buku": "123dd",
  "id_user": "3d2",
  "halaman": 1,
};

const queryBukuHalamanBintang = "SELECT * FROM bukuHalamanBintang WHERE id_buku = ? AND id_user = ?";

final notifications = {
  "id": 0,
  "id_user": "",
  "title": "title",
  "description": "description",
  "imgPath": "nullable",
  "readAt": "", // DATE
  "receivedAt": "", // DATE
};

const queryNotifications = "SELECT * FROM notifications";
const queryInsertNotifications = "INSERT INTO notifications VALUES (?,?,?,?,?,?)";
