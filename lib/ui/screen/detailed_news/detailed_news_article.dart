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
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: ScrollController(
            initialScrollOffset: 0,
            keepScrollOffset: true,
          ),
          slivers: [
            _AppBar(article: article),

            _ArticleContents(article: article),

            const SliverToBoxAdapter(child: Divider()),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Suggestion for you:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const Suggestion(),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final Article article;

  const _AppBar({required this.article});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          shadowColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          itemBuilder: (context) => popupMenuItems(context, article),
        ),
      ],
      foregroundColor: Theme.of(context).colorScheme.primary,
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
                  ..strokeJoin = StrokeJoin.round
                  ..strokeWidth = 6
                  ..color = Theme.of(context).colorScheme.background,
              ),
            ),
            Text(
              article.source?.name ?? article.sourceName ?? 'DR News',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary,
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
    );
  }
}

class _ArticleContents extends StatelessWidget {
  final Article article;

  const _ArticleContents({required this.article});

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
            errorBuilder: (_, __, ___) => Image.asset(
              'assets/images/substitute_image.jpeg',
              width: double.infinity,
            ),
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

///
///Popup menu items
///
List<PopupMenuItem<String>> popupMenuItems(
    BuildContext context, Article article) {
  IconData icon =
      article.id == null ? Icons.save_alt_outlined : Icons.delete_outline;

  String text = article.id == null ? 'Save' : 'Remove';

  String snackBarText = article.id == null ? 'Saved' : 'Removed';

  return [
    PopupMenuItem<String>(
      onTap: () {
        SavedArticleViewModel viewModel = context.read<SavedArticleViewModel>();

        article.sourceName = article.source?.name;
        article.stringPublishedAt = article.publishedAt.toString();

        article.id != null
            ? viewModel.deleteSavedArticle(article.id)
            : viewModel.savingArticle(article);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackBarText),
          ),
        );
      },
      child: Row(
        children: [
          Icon(icon),
          Text(text),
        ],
      ),
    ),
    PopupMenuItem<String>(
      onTap: () {
        ShareArticle().bottomSheet(context, article.title);
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
}
class Suggestion extends StatelessWidget {
  const Suggestion({super.key});

  @override
  Widget build(BuildContext context) {

    ArticleServiceViewModel articleViewModel =
    context.read<ArticleServiceViewModel>();

    List<Article>? articleList = articleViewModel.newsArticle?.articles;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
        child: SizedBox(
          height: 260,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: articleList?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return SuggestionComponent(articleList, index);
            },
          ),
        ),
      ),
    );
  }
}

class SuggestionComponent extends StatelessWidget {
  final List<Article>? articleList;
  final int index;
  const SuggestionComponent(this.articleList, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          Text(
            articleList?[index].title ?? '',
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  articleList?[index].source?.name ??
                      articleList?[index].sourceName ??
                      '',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  softWrap: true,
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                shadowColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                itemBuilder: (context) {
                  return popupMenuItems(context, articleList![index]);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}


