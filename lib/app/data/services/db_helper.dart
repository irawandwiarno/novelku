import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'novelku.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        _createTables(db);
      },
    );
  }

  static void _createTables(Database db) async {
    // Membuat tabel Novel
    await db.execute('''
      CREATE TABLE Novel(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT NOT NULL,
        deskripsi TEXT
      )
    ''');

    // Membuat tabel Chapter dengan foreign key ke tabel Novel
    await db.execute('''
      CREATE TABLE Chapter(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT NOT NULL,
        content TEXT,
        novel_id INTEGER,
        FOREIGN KEY (novel_id) REFERENCES Novel(id)
      )
    ''');
  }

// Menambahkan novel baru
  static Future<int> insertNovel(Map<String, dynamic> novel) async {
    final db = await database;
    return await db.insert('Novel', novel, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Menambahkan chapter baru
  static Future<int> insertChapter(Map<String, dynamic> chapter) async {
    final db = await database;
    return await db.insert('Chapter', chapter, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Mendapatkan chapter berdasarkan novelId
  static Future<List<Map<String, dynamic>>> getChaptersByNovelId(int novelId) async {
    final db = await database;
    return await db.query(
      'Chapter',
      where: 'novel_id = ?',
      whereArgs: [novelId],
    );
  }

  // Mendapatkan novel berdasarkan chapterId
  static Future<Map<String, dynamic>?> getNovelByChapterId(int chapterId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT * FROM Novel WHERE id = (SELECT novel_id FROM Chapter WHERE id = ?)',
      [chapterId],
    );
    return result.isNotEmpty ? result.first : null;
  }


  // Mendapatkan semua novel
  static Future<List<Map<String, dynamic>>> getNovels() async {
    final db = await database;
    return await db.query('Novel');
  }

  // Memperbarui novel
  static Future<void> updateNovel(int id, Map<String, dynamic> novel) async {
    final db = await database;
    await db.update(
      'Novel',
      novel,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Menghapus novel
  static Future<void> deleteNovel(int id) async {
    final db = await database;
    await db.delete(
      'Novel',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Mendapatkan semua chapter
  static Future<List<Map<String, dynamic>>> getChapters() async {
    final db = await database;
    return await db.query('Chapter');
  }

  // Memperbarui chapter
  static Future<void> updateChapter(int id, Map<String, dynamic> chapter) async {
    final db = await database;
    await db.update(
      'Chapter',
      chapter,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Menghapus chapter
  static Future<void> deleteChapter(int id) async {
    final db = await database;
    await db.delete(
      'Chapter',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
