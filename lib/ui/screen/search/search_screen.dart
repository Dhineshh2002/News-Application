import 'package:dr_news/data/model/article_service_view_model.dart';
import 'package:dr_news/ui/screen/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends SearchDelegate {
  List<String> searchTopics = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology',
  ];

  @override
  String? get searchFieldLabel => 'Search for topics and location';

  @override
  TextStyle? get searchFieldStyle =>
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w300);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String>? matchQuery = [];

    for (String items in searchTopics) {
      if (items.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(items);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        String result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (String items in searchTopics) {
      if (items.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(items);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        String result = matchQuery[index];
        return ListTile(
          onTap: () {
            ArticleServiceViewModel vm = context.read<ArticleServiceViewModel>();
            vm.getNewsArticles(category: result.toLowerCase());

            MaterialPageRoute route = MaterialPageRoute(builder: (context) => NewsScreen());
            Navigator.push(context, route);
          },
          title: Text(result),
        );
      },
    );
  }
}