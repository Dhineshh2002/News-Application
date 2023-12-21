import 'package:dr_news/data/model/fetching_news_viewmodel.dart';
import 'package:dr_news/data/providers/fetching_news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'article_component.dart';

class NewsArticles extends StatefulWidget {
  const NewsArticles({super.key});

  @override
  State<NewsArticles> createState() => _NewsArticlesState();
}

class _NewsArticlesState extends State<NewsArticles> {
  Future<NewsArticle>? future;

  @override
  void initState() {
    // TODO: implement initState
    future = FetchingNews().fetchNewsArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<FetchNewsViewModel>(
      builder: (context, vm, child) {
        return Center(
          child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              List<Article>? article = snapshot.data?.articles;
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: article?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: NewsArticleComponent(
                        article: article![index],
                      ),
                    );
                  },
                );
              } else if(snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        );
      },
    );
  }
}
