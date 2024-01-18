import 'package:sqflite/sqflite.dart' as sql;

class SQLParam<T> {
  final String table;
  final Map<String, dynamic>? values;
  final String? where;
  final List<Object?>? whereArgs;

  SQLParam({
    required this.table,
    this.values,
    this.where,
    this.whereArgs,
  });
}

class SQLHelper {
  Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  Future<sql.Database> db() async {
    return sql.openDatabase(
      'nabindhakal.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<List<Map<String, dynamic>>> read() async {
    final database = await db();
    final result = database.query("items");
    return result;
  }

  Future<int> delelte() async {
    final database = await db();
    final result = database.delete("items", where: "", whereArgs: []);
    return result;
  }

  Future<int> update() async {
    final database = await db();
    final result = database.update("items", {});
    return result;
  }

  Future<int> insert() async {
    final database = await db();
    final result = database.insert("items", {});
    return result;
  }
}

final buku = {
  "id": "",
  "lastSeen": 11,
  "totalPages": 120,
  "listStaredPages": "",
  "status": "undone",
};

final notifications = {
  "id": 0,
  "isRead": false,
  "title": "title",
  "description": "description",
  "imgPath": "nullable",
  "createdAt": "",
  "readAt": "",
};
