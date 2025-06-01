import 'package:flutter/material.dart';
import 'package:news_app_project/controller/popularnews_controller.dart';
import 'package:news_app_project/model/news_api_model.dart';
import 'package:news_app_project/view/detailedscreen/detailednews_screen.dart';
import 'package:news_app_project/view/homescreen/widget/newstile.dart';
import 'package:news_app_project/widgets/custom_date.dart';
import 'package:provider/provider.dart';

class PopularNewsScreen extends StatelessWidget {
  const PopularNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PopularnewsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular News'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.popularNewsList.isEmpty
          ? const Center(child: Text('No popular news available.'))
          : RefreshIndicator(
        onRefresh: () async {
          await controller.fetchLatestNews();
        },
        child: ListView.builder(
          itemCount: controller.popularNewsList.length,
          itemBuilder: (context, index) {
            Article article = controller.popularNewsList[index];
            return NewsListTile(
              title: article.title,
              urlToImage: article.urlToImage ?? 'No image found',
              date: CustomDate.formatDate(article.publishedAt),
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
