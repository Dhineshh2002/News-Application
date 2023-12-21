import 'package:dr_news/data/model/article_service_view_model.dart';
import 'package:dr_news/data/providers/article_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'article_component.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ArticleServiceViewModel viewModel = context.read<ArticleServiceViewModel>();

    return Consumer<ArticleServiceViewModel>(
      builder: (context, vm, child) {
        viewModel.getNewsArticles();
        List<Article>? article = viewModel.newsArticle?.articles;

        return Center(
          child: ListView.builder(
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
          ),
        );
      },
    );
  }
}
