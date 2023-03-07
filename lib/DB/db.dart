import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE myUrl(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        my_url TEXT 
      )
      """);
  }
// id: the id of a item s
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'nabindhakal.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> addUrl(String url) async {
    final db = await DatabaseHelper.db();
    final data = {
      'my_url': url,
    };
    final id = await db.insert('myUrl', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getUrl() async {
    final db = await DatabaseHelper.db();
    return db.query('myUrl', orderBy: "id");
  }

  static Future<void> clearUrl() async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("myUrl");
    } catch (err) {}
  }
}
