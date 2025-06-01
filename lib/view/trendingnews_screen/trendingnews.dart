import 'package:flutter/material.dart';
import 'package:news_app_project/controller/trendingnews_controller.dart';
import 'package:news_app_project/model/news_api_model.dart';
import 'package:news_app_project/view/detailedscreen/detailednews_screen.dart';
import 'package:news_app_project/view/homescreen/widget/newscard.dart';
import 'package:news_app_project/widgets/custom_date.dart';
import 'package:provider/provider.dart';

class TrendingNewsScreen extends StatelessWidget {
  const TrendingNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TrendingNewsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending News'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.trendingNewsList.isEmpty
          ? const Center(child: Text('No trending news available.'))
          : RefreshIndicator(
        onRefresh: () async {
          await controller.fetchTrendingNews();
        },
        child: ListView.builder(
          itemCount: controller.trendingNewsList.length,
          itemBuilder: (context, index) {
            Article article = controller.trendingNewsList[index];
            return NewsCard(
              title: article.title,
              imageUrl: article.urlToImage ?? 'No image found',
              time: CustomDate.formatDate(article.publishedAt),
              author: article.author ?? 'Unknown',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetailedNewsScreen(news: article),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
