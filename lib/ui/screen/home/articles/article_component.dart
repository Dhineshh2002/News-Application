import 'package:dr_news/data/providers/fetching_news.dart';
import 'package:dr_news/ui/screen/detailed_news/detailed_news_article.dart';
import 'package:flutter/material.dart';

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
                          article.source?.name ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: color.primary,
                          ),
                          softWrap: true,
                        ),
                      ),
                      PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        onSelected: onHandlePopupMenu,
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem<String>(
                              value: 'Save',
                              child: Row(
                                children: [
                                  Icon(Icons.save_alt_outlined),
                                  Text('Save'),
                                ],
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Share',
                              child: Row(
                                children: [
                                  Icon(Icons.share),
                                  Text('Share'),
                                ],
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Report',
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
  void onHandlePopupMenu(String value) {
    switch (value) {
      case 'Save':
        break;
      case 'Share':
        break;
      case 'Report':
        break;
    }
  }
}
