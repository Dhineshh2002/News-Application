import 'package:dr_news/data/model/article_service_view_model.dart';
import 'package:dr_news/data/model/database_service_view_model.dart';
import 'package:dr_news/ui/screen/home/favorites/favorite_topic.dart';
import 'package:dr_news/ui/screen/home/profile/user_profile.dart';
import 'package:dr_news/ui/screen/home/saved/saved_article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../search/search_screen.dart';
import 'articles/articles_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _selectedIndex = 0;

  final List<String> appBarTitles = [
    'DR News',
    'Favorites',
    'Saved News',
    'Profile info'
  ];

  @override
  void initState() {
    context.read<ArticleServiceViewModel>().getNewsArticles();

    context.read<SavedArticleViewModel>().refreshingArticles();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        actions: _selectedIndex == 0
            ? [
                IconButton(
                  onPressed: () async {
                    String result = await showSearch(
                      context: context,
                      delegate: ArticleSearch(),
                    );

                    result.length == 2
                        ? context
                            .read<ArticleServiceViewModel>()
                            .getNewsArticles(country: result)
                        : context
                            .read<ArticleServiceViewModel>()
                            .getNewsArticles(category: result);
                  },
                  icon: const Icon(
                    Icons.search_sharp,
                  ),
                ),
              ]
            : [],
        title: Text(
          appBarTitles.elementAt(_selectedIndex),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w900,
            fontSize: 35,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: _selectedIndex == 1
              ? const Size.fromHeight(30)
              : const Size.fromHeight(0),
          child: _selectedIndex == 1
              ? const Text(
                  'Choose your favorite Topics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                )
              : const SizedBox(),
        ),
      ),
      drawer: _AppDrawer(
        onTap: () async {
          Navigator.pop(context);
          await Future.delayed(const Duration(milliseconds: 100));
          setState(() {
            _selectedIndex = 3;
          });
        },
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          ArticlesScreen(),
          FavoriteTopics(),
          SavedArticle(),
          UserProfile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_outlined),
            activeIcon: Icon(Icons.star),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save_alt_outlined),
            activeIcon: Icon(Icons.save_alt),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle),
              label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue[50],
        unselectedFontSize: 14.0,
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  final VoidCallback onTap;

  const _AppDrawer({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/sports.png'),
                    radius: 25,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Dhinesh'),
                    InkWell(
                      onTap: onTap,
                      child: const Text(
                        'View profile >',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            splashColor: Theme.of(context).colorScheme.primaryContainer,
            leading: const Icon(Icons.settings_sharp),
            title: const Text('Settings'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            splashColor: Theme.of(context).colorScheme.primaryContainer,
            leading: const Icon(Icons.help_outline),
            title: const Text('Help'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            splashColor: Theme.of(context).colorScheme.primaryContainer,
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About us'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            splashColor: Theme.of(context).colorScheme.primaryContainer,
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
