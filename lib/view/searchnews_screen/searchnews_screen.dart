import 'package:flutter/material.dart';
import 'package:news_app_project/controller/searchnews_controller.dart';
import 'package:news_app_project/view/detailedscreen/detailednews_screen.dart';
import 'package:news_app_project/view/homescreen/widget/newscard.dart';
import 'package:news_app_project/widgets/custom_date.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchNewsController>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 26, color: Color(0xFF16C47F)),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search News...",
                        fillColor: Colors.grey.shade100,
                        border: InputBorder.none,
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (searchController.text.isNotEmpty) {
                        provider.searchedResult(query: searchController.text);
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:Color(0xFF16C47F),
                      ),
                      child: Icon(Icons.search),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: provider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : provider.searchedArticle.isEmpty
                  ? Center(child: Text("No results found"))
                  : ListView.separated(
                itemCount: provider.searchedArticle.length,
                itemBuilder: (context, index) {
                  final article = provider.searchedArticle[index];
                  return NewsCard(
                    imageUrl: article.urlToImage ?? "No image found",
                    author: article.author ?? "Unknown",
                    time: CustomDate.formatDate(article.publishedAt),
                    title: article.title,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailedNewsScreen(news: article),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  thickness: .5,
                  indent: 30,
                  endIndent: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
