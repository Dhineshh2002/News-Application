import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchingNews {
  Future<NewsArticle> fetchNewsArticle() async {
    try{
      final response = await http.get(
        Uri.parse(
            'https://newsapi.org/v2/top-headlines?country=in&apiKey=45b441614a484a82a76cbedd754b9f40'),
      );
      if (response.statusCode == 200) {
        NewsArticle result = NewsArticle.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return result;
      } else {
        print(response.statusCode);
        throw Exception('Failed to load album');
      }
    }catch(e){
      print(e.toString());
      throw e;
    }
  }
}

class NewsArticle {
  String status;
  int? totalResults;
  List<Article>? articles;

  NewsArticle({
    required this.status,
    this.totalResults,
    this.articles,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    List<dynamic> articleList = json['articles'];

    List<Article> articles = articleList.map(
            (e) => Article.fromJson(e)
    ).toList();

    return NewsArticle(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: articles,
    );
  }
}

class Article {
  int? id;
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateAndTime? publishedAt;
  String? content;
  String? sourceName;
  String? stringPublishedAt;

  Article({
    this.id,
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.sourceName,
    this.stringPublishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt:
      DateAndTime.fromString(json['publishedAt'] ?? '0000-00-00T00:00:00Z'),
      content: json['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'news_title': title,
      'author': author,
      'source': sourceName,
      'description': description,
      'published_on': stringPublishedAt,
      'image': urlToImage,
      'content': content,
      'url': url,
    };
  }
}

class Source {
  String? id;
  String name;

  Source({this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
}

class DateAndTime {
  String? date;
  String? time;

  DateAndTime({
    this.time,
    this.date,
  });

  factory DateAndTime.fromString(String dateTime) {
    return DateAndTime(
      date: dateTime.substring(0, 10),
      time: dateTime.substring(11, 19),
    );
  }

  @override
  String toString() => 'Published on: $date, $time';
}
