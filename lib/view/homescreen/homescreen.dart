import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_project/controller/popularnews_controller.dart';
import 'package:news_app_project/controller/trendingnews_controller.dart';
import 'package:news_app_project/view/bookmarkscreen/bookmark_screen.dart';
import 'package:news_app_project/view/detailedscreen/detailednews_screen.dart';
import 'package:news_app_project/view/homescreen/widget/newscard.dart';
import 'package:news_app_project/view/homescreen/widget/newstile.dart';
import 'package:news_app_project/view/popularnews_screen/popularnews_screen.dart';
import 'package:news_app_project/view/trendingnews_screen/trendingnews.dart';
import 'package:news_app_project/widgets/custom_date.dart';
import 'package:news_app_project/widgets/text_builder.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pulltoRefresh();
    });
  }

  Future<void> pulltoRefresh() async {
    await Future.wait([
      context.read<TrendingNewsController>().fetchTrendingNews(),
      context.read<PopularnewsController>().fetchLatestNews(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TrendingNewsController>();
    final controller2 = context.watch<PopularnewsController>();
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF16C47F),
            centerTitle: true,
            leading: Icon(Icons.dehaze_rounded, color: Colors.white),
            title: Text(
              "News Hunt",
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: IconButton(
                  iconSize: 30,
                  color: Colors.white,
                  onPressed: pulltoRefresh,
                  icon: Icon(Icons.refresh),
                ),
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home, color: Colors.white, size: 20)),
                Tab(icon: Icon(Icons.bookmark, color: Colors.white, size: 20)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              RefreshIndicator(
                onRefresh: pulltoRefresh,
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 10, top: 5),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextBuilder(
                              text: 'Trending News',
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TrendingNewsScreen(),
                                  ),
                                );
                              },
                              child: TextBuilder(
                                text: 'See all',
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 200,
                          child: controller.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : CarouselSlider(
                                  options: CarouselOptions(
                                    height: 400,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.8,
                                  ),
                                  items: controller.topFiveTrending.map((e) {
                                    return NewsCard(
                                      imageUrl:
                                          e.urlToImage ?? "No Image found",
                                      title: e.title,
                                      time: CustomDate.formatDate(
                                        e.publishedAt,
                                      ),
                                      author: e.author ?? "Unknown",
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailedNewsScreen(news: e),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            TextBuilder(
                              text: 'Popular News',
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PopularNewsScreen(),
                                  ),
                                );
                              },
                              child: TextBuilder(
                                text: 'See all',
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 300,
                          child: controller2.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : controller2.popularNewsList.isEmpty
                              ? Center(
                                  child: Text('No popular news available.'),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller2.topPopular.length,
                                  itemBuilder: (context, index) {
                                    final news = controller2.topPopular[index];
                                    return NewsListTile(
                                      urlToImage:
                                          news.urlToImage ?? "No Image found",
                                      title: news.title,
                                      date: CustomDate.formatDate(
                                        news.publishedAt,
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailedNewsScreen(news: news),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BookmarkScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
