import 'package:dr_news/ui/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/model/fetching_news_viewmodel.dart';

void main() {
  runApp(const DRNews());
}

class DRNews extends StatelessWidget {
  const DRNews({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FetchNewsViewModel(),
      child: MaterialApp(
        title: 'DR News',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}