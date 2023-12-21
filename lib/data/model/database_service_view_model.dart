import 'package:dr_news/data/providers/database_service.dart';
import 'package:flutter/cupertino.dart';

import '../providers/article_service.dart';

class SavedArticleViewModel extends ChangeNotifier{
  final DatabaseService db = DatabaseService();
  List<Article>? article;

  void savingArticle(Article article) async {
    await db.insertRecord(article);
    refreshingArticles();
  }

  void refreshingArticles() async{
    article = await db.retrieveRecords();
    notifyListeners();
  }

  void deleteSavedArticle(int? id) async{
    await db.deleteRecord(id!);
    refreshingArticles();
  }
}
