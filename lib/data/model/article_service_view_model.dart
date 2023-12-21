
import 'package:dr_news/data/providers/article_service.dart';
import 'package:flutter/cupertino.dart';

class ArticleServiceViewModel extends ChangeNotifier {
  ArticleService articleService = ArticleService();
  NewsArticle? newsArticle;

  void getNewsArticles() async {
    newsArticle = await articleService.fetchNewsArticle();
    notifyListeners();
  }
}