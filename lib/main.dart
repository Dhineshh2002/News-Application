import 'package:dr_news/data/model/database_service_view_model.dart';
import 'package:dr_news/ui/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/model/article_service_view_model.dart';
import 'data/model/theme_model.dart';
import 'data/model/user_detail_view_model.dart';

void main() {
  runApp(const DRNews());
}

class DRNews extends StatelessWidget {
  const DRNews({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ArticleServiceViewModel()),
        ChangeNotifierProvider(create: (context) => SavedArticleViewModel()),
        ChangeNotifierProvider(create: (context) => UserDetailViewModel()),
        ChangeNotifierProvider(create: (context) => ThemeModel()),
      ],
      child: Consumer<ThemeModel>(
        builder: (BuildContext context, ThemeModel value, Widget? child) {
          return MaterialApp(
            title: 'DR News',
            theme: lightThemeData,
            darkTheme: darkThemeData,
            themeMode: value.mode,
            home: const LoginScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
