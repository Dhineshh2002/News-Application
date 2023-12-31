import 'package:flutter/cupertino.dart';

import '../providers/article_service.dart';

class ArticleServiceViewModel extends ChangeNotifier {
  ArticleService articleService = ArticleService();
  NewsArticle? newsArticle;
  bool isFetching = false;

  ///
  /// Getting articles from [ArticleService]
  ///
  Future getNewsArticles({String? category, String? country}) async {
    isFetching = false;

    newsArticle = await articleService.fetchNewsArticle(
      category: category,
      country: country,
    );

    isFetching = true;

    notifyListeners();
  }
}
