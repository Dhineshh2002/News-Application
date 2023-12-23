import 'package:dr_news/data/model/article_service_view_model.dart';
import 'package:dr_news/ui/screen/home/articles/article_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/database_service_view_model.dart';
import '../../../../data/providers/article_service.dart';

class SavedArticle extends StatelessWidget {
  const SavedArticle({super.key});

  @override
  Widget build(BuildContext context) {
    SavedArticleViewModel viewModel = context.read<SavedArticleViewModel>();

    viewModel.refreshingArticles();

    List<Article>? article = viewModel.article;

    return article?.isNotEmpty == true
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              itemCount: article?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Consumer<SavedArticleViewModel>(
                  builder: (ctx, viewModel, child) {
                    return Center(
                      child: NewsArticleComponent(
                        article: article![index],
                      ),
                    );
                  },
                );
              },
            ),
          )
        : const Center(child: Text("You haven't saved any articles"));
  }
}
