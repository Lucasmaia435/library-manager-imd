import 'package:library_manager/models/book.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BookDB {
  static final BookDB instance = BookDB._init();
  static Database? _database;

  BookDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('books.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books (
        isbn TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        author TEXT NOT NULL,
        publisher TEXT NOT NULL,
        description TEXT NOT NULL,
        coverUrl TEXT NOT NULL
      )
    ''');
  }

  Future<int> create(Book book) async {
    final db = await instance.database;
    return await db.rawInsert('''
      INSERT OR REPLACE INTO books (isbn, title, author, publisher, description, coverUrl)
      VALUES (?, ?, ?, ?, ?, ?)
    ''', [
      book.isbn,
      book.title,
      book.author,
      book.publisher,
      book.description,
      book.coverUrl,
    ]);
  }

  Future<List<Book>> readAllBooks() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT * FROM books');
    return result.map((map) => Book.fromMap(map)).toList();
  }

  Future<Book?> readBook(String isbn) async {
    final db = await instance.database;
    final result = await db.rawQuery(
      'SELECT * FROM books WHERE isbn = ?',
      [isbn],
    );
    if (result.isNotEmpty) {
      return Book.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int> update(Book book) async {
    final db = await instance.database;
    return await db.rawUpdate('''
      UPDATE books
      SET title = ?, author = ?, publisher = ?, description = ?, coverUrl = ?
      WHERE isbn = ?
    ''', [
      book.title,
      book.author,
      book.publisher,
      book.description,
      book.coverUrl,
      book.isbn,
    ]);
  }

  Future<int> delete(String isbn) async {
    final db = await instance.database;
    return await db.rawDelete(
      'DELETE FROM books WHERE isbn = ?',
      [isbn],
    );
  }

  Future<void> clearDatabase() async {
    final db = await instance.database;
    await db.rawDelete('DELETE FROM books');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
