import 'package:dr_news/data/providers/database_service.dart';
import 'package:flutter/cupertino.dart';

import '../providers/article_service.dart';

class SavedArticleViewModel extends ChangeNotifier{
  final DatabaseService db = DatabaseService();
  List<Article>? article;
  bool isFetching = false;

  void savingArticle(Article article) async {
    await db.insertRecord(article);
    refreshingArticles();
  }

  void refreshingArticles() async{
    isFetching = false;

    article = await db.retrieveRecords();

    isFetching = true;

    notifyListeners();
  }

  void deleteSavedArticle(int? id) async{
    await db.deleteRecord(id!);
    refreshingArticles();
  }
}
