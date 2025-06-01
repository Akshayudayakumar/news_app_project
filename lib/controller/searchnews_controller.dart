import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_project/model/news_api_model.dart';
import 'package:news_app_project/utils/apiKey.dart';

class SearchNewsController extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<Article> _searchedArticle = [];
  List<Article> get searchedArticle => _searchedArticle;


  searchedResult({required String query}) async{
    try{
      _isLoading = true;
      notifyListeners();
      _searchedArticle.clear();
      final url = Uri.parse(
          "https://newsapi.org/v2/everything?q=$query&from=2025-05-01&sortBy=publishedAt&apiKey=${ApiKey.apiKey}");
      final response = await http.get(url);
      if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        final searchnews = NewsApimodel.fromJson(body);
        _searchedArticle.addAll(searchnews.articles);
      }
    }catch(e){
      print("Exception caught : $e");
    }
    _isLoading = false;
    notifyListeners();
  }
}