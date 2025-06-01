import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_container_flutter/loading_container_flutter.dart';
import 'package:news_app_project/controller/trendingnews_controller.dart';
import 'package:news_app_project/model/news_api_model.dart';
import 'package:news_app_project/widgets/custom_date.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DetailedNewsScreen extends StatelessWidget {
  final Article news;

  DetailedNewsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final bookmarkProvider = Provider.of<TrendingNewsController>(context);
    bool isBookmarked = bookmarkProvider.isBookmarked(news);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: Padding(
          padding: EdgeInsets.all(10.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                       width: width,
                       height: height / 3,
                       child:ClipRRect(
                         borderRadius: BorderRadius.circular(20),
                         child: CachedNetworkImage(
                           imageUrl: news.urlToImage ?? "No image found",
                           height: 100,
                           fit: BoxFit.cover,
                           placeholder: (context, url) => Shimmer.fromColors(
                             baseColor: Colors.grey,
                             highlightColor: Colors.white,
                             child: LoadingContainerWidget(width:width, height:height),
                           ),
                           errorWidget: (context, url, error) => const Icon(Icons.error),
                         ),
                       ),
                     ),
                     Positioned(top: 10.h, left: 10.w,
                       child: GestureDetector(
                       onTap: () {
                         Navigator.pop(context);
                       },
                       child: Container(
                           height: 40.h,
                           width: 40.w,
                           padding: EdgeInsets.all(5.r),
                           decoration: BoxDecoration(
                             color: Colors.black38,
                             borderRadius: BorderRadius.circular(20),
                           ),
                           child: Center(
                             child: Icon(
                               Icons.arrow_back_ios_outlined,
                               color: Colors.white,
                               size: 28.sp,
                             ),
                           )),
                     ),),
                     Positioned(
                       top: 10.h,right: 10.w,
                       child: GestureDetector(
                         onTap: () {
                           if (isBookmarked) {
                             bookmarkProvider.removeBookmark(news);
                           } else {
                             bookmarkProvider.addBookmark(news);
                           }
                         },
                         child: Container(
                           height: 40.h,
                           width: 40.w,
                           padding: EdgeInsets.all(5),
                           decoration: BoxDecoration(
                             color: Colors.black38,
                             borderRadius: BorderRadius.circular(20),
                           ),
                           child: Center(
                               child: FaIcon(
                                 isBookmarked ? FontAwesomeIcons.solidBookmark :
                                 FontAwesomeIcons.bookmark,
                                 color: Colors.white,
                                 size: 25.sp,
                               )),
                         ),
                       ),
                     ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  news.description ?? "No Description",
                  style: GoogleFonts.alegreya(
                      fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(CustomDate.formatDate(news.publishedAt),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                if (news.author != null && news.author!.isNotEmpty)
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 15.sp,
                        child: Center(
                            child: Text(news.author![0].toUpperCase())),
                      ),
                      SizedBox(width: 10.w),
                      Flexible(
                        child: Text(
                          news.author!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    ],
                  ),
                SizedBox(height: 10.h),
                Text(
                  news.content ?? "No Content",
                  style: GoogleFonts.roboto(fontSize: 14.sp),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
