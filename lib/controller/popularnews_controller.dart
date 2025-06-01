import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_project/model/news_api_model.dart';
import 'package:news_app_project/utils/apiKey.dart';

class PopularnewsController with ChangeNotifier {

  List<Article> _popularNewsList = [];
  List<Article> _topPopular = [];

  bool _isLoading = false;
  bool _isPopular = false;


  List<Article> get popularNewsList => _popularNewsList;
  List<Article> get topPopular => _topPopular;

  bool get isLoading => _isLoading;
  bool get isLatest => _isPopular;


  Future<void> fetchLatestNews() async {
    _isLoading = true;
    notifyListeners();
    topPopular.clear();
    popularNewsList.clear();

    final url = Uri.parse(
      "https://newsapi.org/v2/everything?q=apple&from=2025-05-31&to=2025-05-31&sortBy=popularity&apiKey=${ApiKey.apiKey}",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final news = NewsApimodel.fromJson(data);

        _popularNewsList = news.articles;
        _topPopular = _popularNewsList.take(5).toList();
        _isPopular = true;
      } else {
        if (kDebugMode) {
          print("Failed to load latest news: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
