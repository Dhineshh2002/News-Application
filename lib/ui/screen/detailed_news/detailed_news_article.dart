import 'package:dr_news/data/model/fetching_news_viewmodel.dart';
import 'package:dr_news/data/providers/fetching_news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedNews extends StatelessWidget {
  final Article article;

  const DetailedNews({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;

    FetchNewsViewModel vm = context.watch<FetchNewsViewModel>();
    List<Article>? articleList = vm.newsArticle?.articles;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: ScrollController(
            initialScrollOffset: 299,
            keepScrollOffset: false,
          ),
          slivers: [
            SliverAppBar(
              actions: [
                PopupMenuButton(
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
              foregroundColor: color.primary,
              backgroundColor: Colors.blue[50],
              pinned: true,
              expandedHeight: 350,
              flexibleSpace: FlexibleSpaceBar(
                title: Stack(
                  children: <Widget>[
                    Text(
                      article.source?.name ?? 'DR NEWS',
                      style: TextStyle(
                        fontSize: 20,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.blue[700]!,
                      ),
                    ),
                    Text(
                      article.source?.name ?? 'DR News',
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
                    'assets/substitute_image.jpeg',
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SliverList.list(
              children: [
                Text(
                  article.title ?? '',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 27),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  article.author != null ? 'By ${article.author}' : '',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                Divider(),
                Text(
                  article.publishedAt.toString(),
                  style: TextStyle(fontSize: 12),
                ),
                Divider(),
                Text(
                  article.description ?? '',
                  style: TextStyle(fontSize: 20),
                ),
                Image.network(
                  article.urlToImage ?? '',
                  width: double.infinity,
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) => Text(''),
                ),
                Text(
                  'And, even with this week’s temporary “humanitarian pause” and exchange of prisoners and hostages, the powers that be have shown no interest whatsoever in listening to the thundering calls for a permanent ceasefire that are coming from governments and mass demonstrations around the world, particularly the Biden administration here in the United States, the increasingly fascistic Netanyahu government in Israel, and the arms manufacturers and war profiteers who are raking in billions from manufacturing mass death. This is prompting activists and people of conscience around the world to take direct action themselves to try to disrupt the war machine. And that includes working people in trade unions. In Australia, for instance, direct actions and protests have exploded across the country. And, even with this week’s temporary “humanitarian pause” and exchange of prisoners and hostages, the powers that be have shown no interest whatsoever in listening to the thundering calls for a permanent ceasefire that are coming from governments and mass demonstrations around the world, particularly the Biden administration here in the United States, the increasingly fascistic Netanyahu government in Israel, and the arms manufacturers and war profiteers who are raking in billions from manufacturing mass death. This is prompting activists and people of conscience around the world to take direct action themselves to try to disrupt the war machine. And that includes working people in trade unions. In Australia, for instance, direct actions and protests have exploded across the country. ${article.content ?? ''}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                )
              ],
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Suggestion for you',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 240,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: articleList?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 250,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          articleList?[index].urlToImage ?? '',
                          width: 250,
                          fit: BoxFit.fill,
                          errorBuilder: (_, __, ___) => Image.asset('assets/substitute_image.jpeg'),
                        ),
                        Text(articleList?[index].source?.name ?? 'D R'),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
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
