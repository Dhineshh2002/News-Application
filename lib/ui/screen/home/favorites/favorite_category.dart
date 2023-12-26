import 'package:flutter/material.dart';

class FavoriteTopics extends StatefulWidget {
  const FavoriteTopics({super.key});

  @override
  State<FavoriteTopics> createState() => _FavoriteTopicsState();
}

class _FavoriteTopicsState extends State<FavoriteTopics> {
  List<Favorite> favorite = [];
  List<String> favoritesTopics = [
    'Economy',
    'Education',
    'Entertainment',
    'Environment',
    'Fashion',
    'Government',
    'Health',
    'Politics',
    'Religious',
    'Science',
    'Sports',
    'Technology',
  ];
  List<String> favoritesImageUrls = [
    'assets/images/economy.png',
    'assets/images/education.png',
    'assets/images/entertainment.png',
    'assets/images/environment.png',
    'assets/images/fashion.png',
    'assets/images/government.png',
    'assets/images/health.png',
    'assets/images/politics.png',
    'assets/images/religious.png',
    'assets/images/science.png',
    'assets/images/sports.png',
    'assets/images/technology.png',
  ];

  void initializeFavorites() {
    for (int i = 0; i < 12; i++) {
      favorite.add(
        Favorite(
          imageUrl: favoritesImageUrls[i],
          topic: favoritesTopics[i],
        ),
      );
    }
  }

  @override
  void initState() {
    initializeFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          mainAxisExtent: 250,
        ),
        itemCount: favorite.length,
        itemBuilder: (BuildContext context, int index) {
          return FavoriteTopicsComponent(
            favorite: favorite[index],
            onPressed: () {
              setState(() {
                favorite[index].isFavorite = !favorite[index].isFavorite;
              });
            },
          );
        },
      ),
    );
  }
}

class FavoriteTopicsComponent extends StatelessWidget {
  final Favorite favorite;

  final VoidCallback onPressed;

  const FavoriteTopicsComponent(
      {super.key, required this.favorite, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              favorite.imageUrl,
              height: 150,
              errorBuilder: (_, __, ___) {
                return const Text('Error');
              },
            ),
          ),
          Text(
            favorite.topic,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            child: favorite.isFavorite
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border_outlined),
          ),
        ],
      ),
    );
  }
}

class Favorite {
  String imageUrl;
  String topic;
  bool isFavorite;

  Favorite({
    required this.imageUrl,
    required this.topic,
    this.isFavorite = false,
  });
}
