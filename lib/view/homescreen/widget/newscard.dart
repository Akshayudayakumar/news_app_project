import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_container_flutter/loading_container_flutter.dart';
import 'package:shimmer/shimmer.dart';

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String time;
  final VoidCallback onTap;

  const NewsCard(
      {super.key,
        required this.imageUrl,
        required this.author,
        required this.time,
        required this.title,
        required this.onTap,});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10,top: 5),
        padding: EdgeInsets.all(10),
        height: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Uri.tryParse(imageUrl)?.hasAbsolutePath == true ?
                CachedNetworkImage(
                  imageUrl: imageUrl,fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Shimmer.fromColors(baseColor:Colors.grey, highlightColor: Colors.white, child: LoadingContainerWidget(width: width,height: height,),),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ): Icon(Icons.broken_image,size: 50,color: Colors.grey)
              ),
            ),
            SizedBox(width: 10),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.orange,
                          child: Center(
                              child: Text(
                                author[0],
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            author,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        )
                      ],
                    ),
                    Flexible(child: Text(title, maxLines: 3)),
                    Text(time,
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
