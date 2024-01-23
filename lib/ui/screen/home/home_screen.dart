import 'package:dr_news/data/model/article_service_view_model.dart';
import 'package:dr_news/data/model/database_service_view_model.dart';
import 'package:dr_news/ui/screen/home/favorites/favorite_category.dart';
import 'package:dr_news/ui/screen/home/profile/user_profile.dart';
import 'package:dr_news/ui/screen/home/saved/saved_article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/theme_model.dart';
import '../search/search_screen.dart';
import 'articles/articles_screen.dart';

class NewsScreen extends StatefulWidget {
  final String userName;

  const NewsScreen({super.key, required this.userName});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _selectedIndex = 0;

  final List<String> appBarTitles = [
    'DR News',
    'Favorites',
    'Saved News',
    'Profile',
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
                    changingArticleCategory(result);
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
            color: Theme.of(context).colorScheme.onBackground,
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
        userName: widget.userName,
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
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: ArticlesScreen(),
          ),
          const FavoriteTopics(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: SavedArticle(),
          ),
          UserProfile(
            userName: widget.userName,
          ),
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
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14.0,
      ),
    );
  }

  void changingArticleCategory(String result) {
    ArticleServiceViewModel viewModel = context.read<ArticleServiceViewModel>();

    result.length == 2
        ? viewModel.getNewsArticles(country: result)
        : viewModel.getNewsArticles(category: result);
  }
}

class _AppDrawer extends StatelessWidget {
  final String userName;
  final VoidCallback onTap;

  const _AppDrawer({required this.onTap, required this.userName});

  @override
  Widget build(BuildContext context) {
    ThemeModel themeModel = context.read<ThemeModel>();

    Icon themeIcon = themeModel.mode == ThemeMode.dark
        ? const Icon(Icons.sunny)
        : const Icon(Icons.nights_stay);

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
                    Text(userName),
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
          ),
          ListTile(
            splashColor: Theme.of(context).colorScheme.primaryContainer,
            leading: themeIcon,
            title: const Text("Change Theme"),
            onTap: () {
              context.read<ThemeModel>().toggleMode();
            },
          )
        ],
      ),
    );
  }
}
