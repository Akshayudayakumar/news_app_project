import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_project/model/news_api_model.dart';
import 'package:news_app_project/utils/apiKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrendingNewsController with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late SharedPreferences preferences;

  List<Article> _trendingNewsList = [];
  List<Article> _topFiveTrending = [];
  List<Article> _bookmarksList = [];

  List<Article> get trendingNewsList => _trendingNewsList;
  List<Article> get topFiveTrending => _topFiveTrending;
  List<Article> get bookmarksList => _bookmarksList;

  bool isBookmarked(Article article){
    return _bookmarksList.any((element) => element.url == article.url);
  }
  Future<void> loadBookmarks() async{
    preferences = await SharedPreferences.getInstance();
    final List<String>?bookmarks =  preferences.getStringList('bookmarks');
    if(bookmarks != null){
      _bookmarksList = bookmarks.map((e) => Article.fromJson(jsonDecode(e))).toList();

    }
  }
  Future<void> addBookmark(Article article) async {
    if(!isBookmarked(article)){
      _bookmarksList.add(article);
      await saveBookmarks();
      notifyListeners();
    }
  }
  Future<void> removeBookmark(Article article) async{
    _bookmarksList.removeWhere((element) => element.url == article.url);
    await saveBookmarks();
    notifyListeners();
  }

  Future<void> saveBookmarks() async{
    preferences = await SharedPreferences.getInstance();
    final List<String>bookmarks = _bookmarksList.map((e) => jsonEncode(e)).toList();
    await preferences.setStringList('bookmarks',bookmarks);
  }

  Future<void> fetchTrendingNews() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=${ApiKey.apiKey}",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status'] == 'ok') {
          NewsApimodel news = NewsApimodel.fromJson(data);

          _trendingNewsList = news.articles;
          _topFiveTrending = news.articles.take(5).toList();

          print("Fetched ${news.articles.length} articles.");
        } else {
          print("API Error: ${data['message']}");
        }
      } else {
        print("Failed to load news: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
