
import 'package:dr_news/data/providers/fetching_news.dart';
import 'package:flutter/cupertino.dart';

class FetchNewsViewModel extends ChangeNotifier {
  FetchingNews fetchingNews = FetchingNews();
  NewsArticle? newsArticle;

  void getNewsArticles() async {
    newsArticle = await fetchingNews.fetchNewsArticle();
    notifyListeners();
  }
}