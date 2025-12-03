import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart';

import 'sql_constants.dart';

class SQLParam<T> {
  final String table;
  final Map<String, Object?>? values;
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
  static sql.Database? _database;

  Future<void> createTables(sql.Database database) async {
    final createBukuQuery = """CREATE TABLE IF NOT EXISTS ${constants.table.buku}(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      id_buku TEXT NOT NULL,
      id_user TEXT NOT NULL,
      last_page_seen INTEGER,
      total_pages INTEGER NOT NULL,
      expired DATE,
      status TEXT DEFAULT "Belum Dibaca",
      asset_sampul_path TEXT,
      asset_buku_path TEXT,
      judul TEXT NOT NULL,
      penulis TEXT NOT NULL,
      tipe TEXT NOT NULL
    )""";
    final createBukuHalamanBintangQuery = """CREATE TABLE IF NOT EXISTS ${constants.table.bukuHalamanBintang}(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      id_buku TEXT NOT NULL,
      id_user TEXT NOT NULL,
      halaman INTEGER NOT NULL
    )""";
    final createNotifikasiQuery = """CREATE TABLE IF NOT EXISTS ${constants.table.notifikasi}(
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

  Future<String> _getDatabasePath() async {
    try {
      final dbDir = await getApplicationDocumentsDirectory();
      final dbPath = join(dbDir.path, constants.databaseName);
      debugPrint('Database path: $dbPath');
      return dbPath;
    } catch (e) {
      debugPrint('Error getting database path: $e');
      rethrow;
    }
  }

  Future<sql.Database> db() async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }

    late String path;
    late sql.DatabaseFactory factory;

    try {
      if (Platform.isAndroid || Platform.isIOS) {
        path = join(await sql.getDatabasesPath(), constants.databaseName);
        factory = sql.databaseFactory;
        debugPrint('Mobile platform - Database path: $path');
      } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        path = await _getDatabasePath();
        factory = databaseFactoryFfi;
        debugPrint('Desktop platform - Database path: $path');
      } else {
        throw UnsupportedError('Unsupported platform');
      }

      _database = await factory.openDatabase(
        path,
        options: sql.OpenDatabaseOptions(
          version: 1,
          onCreate: (sql.Database database, int version) async {
            debugPrint('Creating database tables...');
            await createTables(database);
            debugPrint('Database tables created successfully');
          },
        ),
      );
      
      debugPrint('Database opened successfully');
      return _database!;
    } catch (e) {
      debugPrint('Error opening database: $e');
      rethrow;
    }
  }

  Future<List<Map<String, Object?>>> read(SQLParam param) async {
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

  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }
}

final SQLHelper sqlHelper = SQLHelper();
