import 'package:path/path.dart';
import 'package:sample_service/models/docs_model.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService{
  static const String databaseName = "database.db";
  static Database? db;

  static Future<Database> initDb() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return db?? await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          //await createTables(db);
          await db.execute(
            'CREATE TABLE IF NOT EXISTS docs(id INTEGER PRIMARY KEY, title TEXT, docType TEXT, laptopId TEXT, doc BLOB)'
          );
        });
  }


  static Future<void> insertDoc(Database db, DocModel doc) async {
    await db.insert(
      'docs',
      doc.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> createTables(Database database) async{
    /*
      late final int id;
  late final String title;
  late final String docType;
  late final String laptopId;
  late final Uint8List doc;
    CREATE TABLE IF NOT EXISTS TABLE_NAME (column_name datatype, column_name datatype)
     */
    await database.execute("""CREATE TABLE IF NOT EXISTS DOCMODEL (
        ID INT NOT NULL,
        TITLE TEXT NOT NULL,
        DOCTYPE TEXT NOT NULL,
        LAPTOPID TEXT NOT NULL,
        DOC VARCHAR(16) NOT NULL
      )      
      """);
  }

// static const String databaseName = "database.db";
  // static Database? db;
  //
  // static Future<Database> initizateDb() async{
  //   final databasePath = await getDatabasesPath();
  //   final path = join(databasePath, databaseName);
  //   return db?? await openDatabase(
  //       path,
  //       version: 1,
  //       onCreate: (Database db, int version) async {
  //         await createTables(db);
  //       });
  // }
  //
  // static Future<void> createTables(Database database) async{
  //   await database.execute("""CREATE TABLE IF NOT EXISTS Notes (
  //       Id TEXT NOT NULL,
  //       Title TEXT NOT NULL,
  //       Description TEXT NOT NULL,
  //     )
  //     """);
  // }
  //
  // static Future<int> createItem(Doc note) async {
  //   final db = await SqliteService.initizateDb();
  //
  //   final id = await db.insert('Notes', note.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  //   return id;
  // }
  //
  // // Read all notes
  // static Future<List<Note>> getItems() async {
  //   final db = await SqliteService.initizateDb();
  //
  //   final List<Map<String, Object?>> queryResult = await db.query('Notes');
  //   return queryResult.map((e) => Note.fromMap(e)).toList();
  // }
}