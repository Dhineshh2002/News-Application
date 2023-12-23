import 'package:dr_news/data/providers/article_service.dart';
import 'package:flutter/cupertino.dart';

class ArticleServiceViewModel extends ChangeNotifier {
  final ArticleService articleService = ArticleService();
  NewsArticle? newsArticle;

  void getNewsArticles({String? category}) async {
    newsArticle = await articleService.fetchNewsArticle(category: category);
    notifyListeners();
  }
}
