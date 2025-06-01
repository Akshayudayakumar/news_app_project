import 'package:flutter/material.dart';
import 'package:news_app_project/controller/trendingnews_controller.dart';
import 'package:news_app_project/view/detailedscreen/detailednews_screen.dart';
import 'package:news_app_project/widgets/custom_date.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<TrendingNewsController>(context);
    final bookmarks = bookmarkProvider.bookmarksList;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bookmarks",
          style: GoogleFonts.alegreya(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: bookmarks.isEmpty
          ? Center(
        child: Text(
          "No bookmarks yet.",
          style: GoogleFonts.roboto(fontSize: 18.sp),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(10.r),
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          final article = bookmarks[index];
          return Card(
            margin: EdgeInsets.only(bottom: 10.h),
            child: ListTile(
              contentPadding: EdgeInsets.all(10.r),
              leading: article.urlToImage != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  article.urlToImage!,
                  width: 80.w,
                  fit: BoxFit.cover,
                ),
              )
                  : null,
              title: Text(
                article.title,
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(CustomDate.formatDate(article.publishedAt),
                style: TextStyle(fontSize: 12.sp),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  bookmarkProvider.removeBookmark(article);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailedNewsScreen(news: article),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
