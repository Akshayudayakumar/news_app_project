
class NewsApimodel{
  final String status;
  final int totalResults;
  final List<Article> articles;

  NewsApimodel({required this.status, required this.totalResults, required this.articles});

  factory NewsApimodel.fromJson(Map<String, dynamic> json) {
    return NewsApimodel(
      status: json["status"],
      totalResults: json["totalResults"],
      articles: (json["articles"] as List).map((article) => Article.fromJson(article)).toList(),
    );
  }
}
class Article{

  final Source source;

  final String? author;

  final String title;

  final String? description;

  final String url;

  final String? urlToImage;

  final String publishedAt;

  final String? content;

  Article({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json["source"]),
      author: json["author"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: json["publishedAt"],
      content: json["content"],
    );
  }
}
class Source{
  final String? id;

  final String name;

  Source({this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json["id"],
      name: json["name"],
    );
  }
}
