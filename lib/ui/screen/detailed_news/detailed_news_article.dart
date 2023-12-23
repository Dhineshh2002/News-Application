
import 'package:dr_news/data/model/article_service_view_model.dart';
import 'package:dr_news/data/model/database_service_view_model.dart';
import 'package:dr_news/data/providers/article_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/share_article.dart';

class DetailedNews extends StatelessWidget {
  final Article article;

  const DetailedNews({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;

    ArticleServiceViewModel articleViewModel =
        context.read<ArticleServiceViewModel>();

    List<Article>? articleList = articleViewModel.newsArticle?.articles;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: ScrollController(
            initialScrollOffset: 0,
            keepScrollOffset: true,
          ),
          slivers: [
            SliverAppBar(
              actions: [
                _AppBarPoppupMenu(
                  article: article,
                ),
              ],
              foregroundColor: color.primary,
              backgroundColor: Colors.blue[50],
              pinned: true,
              expandedHeight: 350,
              flexibleSpace: FlexibleSpaceBar(
                title: Stack(
                  children: <Widget>[
                    Text(
                      article.source?.name ?? article.sourceName ?? 'DR NEWS',
                      style: TextStyle(
                        fontSize: 20,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.black45,
                      ),
                    ),
                    Text(
                      article.source?.name ?? article.sourceName ?? 'DR News',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                background: Image.network(
                  article.urlToImage ?? '',
                  width: double.infinity,
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/images/substitute_image.jpeg',
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            _DetailedNewsArticleData(article: article),
            const SliverToBoxAdapter(child: Divider()),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Suggestion for you',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            _DetailedNewsSuggestions(articleList: articleList),
          ],
        ),
      ),
    );
  }
}

class _AppBarPoppupMenu extends StatelessWidget {
  final Article article;

  const _AppBarPoppupMenu({required this.article});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem<String>(
            onTap: () {
              SavedArticleViewModel viewModel =
                  context.read<SavedArticleViewModel>();
              article.sourceName = article.source?.name;
              article.stringPublishedAt = article.publishedAt.toString();

              article.id != null
                  ? viewModel.deleteSavedArticle(article.id)
                  : viewModel.savingArticle(article);
            },
            child: Row(
              children: [
                const Icon(Icons.save_alt_outlined),
                article.id == null ? const Text('Save') : const Text('Delete'),
              ],
            ),
          ),
          PopupMenuItem<String>(
            onTap: () => ShareArticle().bottomSheet(context),
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
    );
  }
}

class _DetailedNewsArticleData extends StatelessWidget {
  final Article article;

  const _DetailedNewsArticleData({required this.article});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            article.title ?? '',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 27),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            article.author != null ? 'By ${article.author}' : '',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            article.publishedAt.toString(),
            style: const TextStyle(fontSize: 12),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            article.description ?? '',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Image.network(
            article.urlToImage ?? '',
            width: double.infinity,
            fit: BoxFit.fill,
            errorBuilder: (_, __, ___) => const Text(''),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'And, even with this week’s temporary “humanitarian pause” and exchange of prisoners and hostages, the powers that be have shown no interest whatsoever in listening to the thundering calls for a permanent ceasefire that are coming from governments and mass demonstrations around the world, particularly the Biden administration here in the United States, the increasingly fascistic Netanyahu government in Israel, and the arms manufacturers and war profiteers who are raking in billions from manufacturing mass death. This is prompting activists and people of conscience around the world to take direct action themselves to try to disrupt the war machine. And that includes working people in trade unions. In Australia, for instance, direct actions and protests have exploded across the country. And, even with this week’s temporary “humanitarian pause” and exchange of prisoners and hostages, the powers that be have shown no interest whatsoever in listening to the thundering calls for a permanent ceasefire that are coming from governments and mass demonstrations around the world, particularly the Biden administration here in the United States, the increasingly fascistic Netanyahu government in Israel, and the arms manufacturers and war profiteers who are raking in billions from manufacturing mass death. This is prompting activists and people of conscience around the world to take direct action themselves to try to disrupt the war machine. And that includes working people in trade unions. In Australia, for instance, direct actions and protests have exploded across the country. ${article.content ?? ''}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}

class _DetailedNewsSuggestions extends StatelessWidget {
  final List<Article>? articleList;

  const _DetailedNewsSuggestions({required this.articleList});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          height: 240,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: articleList?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    articleList?[index].urlToImage ?? '',
                    width: 240,
                    height: 120,
                    fit: BoxFit.fill,
                    errorBuilder: (_, __, ___) => Image.asset(
                      'assets/images/substitute_image.jpeg',
                      width: 240,
                      height: 120,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(articleList?[index].source?.name ?? 'DR News'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
