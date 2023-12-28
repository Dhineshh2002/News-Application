import 'package:flutter/material.dart';

class ArticleSearch extends SearchDelegate {
  Map<String, String> searchTopics = {
    "Business": "business",
    "Entertainment": "entertainment",
    "General": "general",
    "Health": "health",
    "Science": "Sports",
    "Technology": "technology",
    "Sports": "sports",
    "United Arab Emirates": "ae",
    "Argentina": "ar",
    "Austria": "at",
    "Australia": "au",
    "Belgium": "be",
    "Bulgaria": "bg",
    "Brazil": "br",
    "Canada": "ca",
    "Switzerland": "ch",
    "China": "cn",
    "Colombia": "co",
    "Cuba": "cu",
    "Czech Republic": "cz",
    "Germany": "de",
    "Egypt": "eg",
    "France": "fr",
    "United Kingdom": "gb",
    "Greece": "gr",
    "Hong Kong": "hk",
    "Hungary": "hu",
    "Indonesia": "id",
    "Ireland": "ie",
    "Israel": "il",
    "India": "in",
    "Italy": "it",
    "Japan": "jp",
    "South Korea": "kr",
    "Lithuania": "lt",
    "Latvia": "lv",
    "Morocco": "ma",
    "Mexico": "mx",
    "Malaysia": "my",
    "Nigeria": "ng",
    "Netherlands": "nl",
    "Norway": "no",
    "New Zealand": "nz",
    "Philippines": "ph",
    "Poland": "pl",
    "Portugal": "pt",
    "Romania": "ro",
    "Serbia": "rs",
    "Russia": "ru",
    "Saudi Arabia": "sa",
    "Sweden": "se",
    "Singapore": "sg",
    "Slovenia": "si",
    "Slovakia": "sk",
    "Thailand": "th",
    "Turkey": "tr",
    "Taiwan": "tw",
    "Ukraine": "ua",
    "United States": "us",
    "Venezuela": "ve",
    "South Africa": "za",
  };

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
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];

    if (query.isNotEmpty) {
      for (String items in searchTopics.keys) {
        if (items.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(items);
        }
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        String result = matchQuery[index];

        return ListTile(
          onTap: () {
            close(context, searchTopics[result]);
          },
          title: Text(result),
        );
      },
    );
  }
}
