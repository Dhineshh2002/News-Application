import 'package:dr_news/data/providers/article_service.dart';
import 'package:flutter/cupertino.dart';

class ArticleServiceViewModel extends ChangeNotifier {
  ArticleService articleService = ArticleService();
  NewsArticle? newsArticle;
  bool isFetching = false;

  ///
  /// Getting articles from [ArticleService]
  ///
  Future getNewsArticles({String? category}) async {
    isFetching = false;

    newsArticle = await articleService.fetchNewsArticle(category: category);

    isFetching = true;

    notifyListeners();
  }
}
