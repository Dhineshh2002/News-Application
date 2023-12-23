import 'package:dr_news/data/model/database_service_view_model.dart';
import 'package:dr_news/data/providers/article_service.dart';
import 'package:dr_news/ui/screen/detailed_news/detailed_news_article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/share_article.dart';

class NewsArticleComponent extends StatelessWidget {
  final Article article;

  const NewsArticleComponent({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 10,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              color: Colors.blue[50],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    article.title ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Times new roman',
                      fontSize: 18,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      article.author != null ? '- by ${article.author}' : '',
                    ),
                  ),
                  Image.network(
                    article.urlToImage ?? '',
                    width: MediaQuery.of(context).size.width,
                    errorBuilder: (_, __, ___) {
                      return Image.asset(
                        'assets/images/substitute_image.jpeg',
                        width: double.infinity,
                      );
                    },
                  ),
                  Text(
                    article.description ?? '',
                    textAlign: TextAlign.justify,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          article.source?.name ?? article.sourceName ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: color.primary,
                          ),
                          softWrap: true,
                        ),
                      ),
                      PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem<String>(
                              onTap: () {
                                SavedArticleViewModel viewModel = context.read<SavedArticleViewModel>();

                                article.sourceName = article.source?.name;
                                article.stringPublishedAt = article.publishedAt.toString();

                                article.id != null
                                    ? viewModel.deleteSavedArticle(article.id)
                                    : viewModel.savingArticle(article);
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.save_alt_outlined),
                                  article.id == null ? Text('Save') : Text('Delete'),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              onTap: () {
                                ShareArticle().bottomSheet(context);
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.share),
                                  Text('Share'),
                                ],
                              ),
                            ),
                            const PopupMenuItem<String>(
                              child: Row(
                                children: [
                                  Icon(Icons.report_gmailerrorred),
                                  Text('Report'),
                                ],
                              ),
                            )
                          ];
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailedNews(article: article),
              ),
            );
          },
        ),
      ),
    );
  }
}
