import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'article_service.dart';

class DatabaseService {
  Future<Database> getDatabase() async {
    Database db = await openDatabase(
      join(await getDatabasesPath(), 'SavedArticlesDb.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE SavedArticles(id INTEGER PRIMARY KEY AUTOINCREMENT, article_title TEXT, author TEXT, source TEXT, description TEXT, published_on TEXT, image TEXT, content TEXT, url TEXT)',
        );
      },
    );
    return db;
  }

  Future<void> insertRecord(Article article) async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> articleList = await db.query('SavedArticles');

    bool flag = true;
    for (int i = 0; i < articleList.length; i++) {
      if (articleList[i]['article_title'] == article.title) {
        flag = false;
      }
    }

    flag == true
        ? db.insert(
            'SavedArticles',
            article.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          )
        : null;
  }

  Future<List<Article>> retrieveRecords() async {
    Database db = await getDatabase();

    List<Map<String, dynamic>> map = await db.query('SavedArticles');

    return List.generate(
      map.length,
      (index) {
        return Article(
          id: map[index]['id'],
          title: map[index]['article_title'],
          author: map[index]['author'],
          sourceName: map[index]['source'],
          description: map[index]['description'],
          stringPublishedAt: map[index]['published_on'],
          urlToImage: map[index]['image'],
          content: map[index]['content'],
          url: map[index]['url'],
        );
      },
    );
  }

  Future<void> deleteRecord(int id) async {
    Database db = await getDatabase();

    await db.delete(
      'SavedArticles',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
