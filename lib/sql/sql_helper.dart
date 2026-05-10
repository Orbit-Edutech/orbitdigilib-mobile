import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'sql_constants.dart';

final SQLHelper sqlHelper = SQLHelper();

class SQLHelper {
  static sql.Database? _database;
  final SQLConstants constants = SQLConstants();

  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }

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

  Future<sql.Database> db() async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }

    try {
      final path = await _getDatabasePath();
      final factory = getDatabaseFactory();

      debugPrint('Opening database with factory: ${factory.runtimeType}');

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

      debugPrint('Database opened successfully at: $path');
      return _database!;
    } catch (e) {
      debugPrint('Error opening database: $e');
      rethrow;
    }
  }

  Future<int> delete(SQLParam param) async {
    final database = await db();
    final result = database.delete(
      param.table,
      where: param.where,
      whereArgs: param.whereArgs,
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

  Future<String> _getDatabasePath() async {
    try {
      String dbPath;

      if (Platform.isAndroid || Platform.isIOS) {
        // Mobile platforms: use getDatabasesPath()
        dbPath = join(await sql.getDatabasesPath(), constants.databaseName);
      } else if (Platform.isWindows) {
        // Windows: use AppData\Local
        final appDataPath = Platform.environment['LOCALAPPDATA'];
        if (appDataPath == null || appDataPath.isEmpty) {
          throw Exception('LOCALAPPDATA environment variable not found');
        }
        final dbDir = join(appDataPath, 'Orbit Digilib');
        final directory = Directory(dbDir);
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        dbPath = join(dbDir, constants.databaseName);
      } else if (Platform.isMacOS || Platform.isLinux) {
        // macOS & Linux: use Documents directory
        final docDir = await getApplicationDocumentsDirectory();
        dbPath = join(docDir.path, constants.databaseName);
      } else {
        throw UnsupportedError('Unsupported platform');
      }

      debugPrint('Database path: $dbPath');
      return dbPath;
    } catch (e) {
      debugPrint('Error getting database path: $e');
      rethrow;
    }
  }

  // Get appropriate database factory based on platform
  static DatabaseFactory getDatabaseFactory() {
    if (Platform.isAndroid || Platform.isIOS) {
      return sql.databaseFactory;
    } else {
      return databaseFactoryFfi;
    }
  }
}

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
