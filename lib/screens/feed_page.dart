
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/feed_Controller.dart';

class FeedPage extends StatelessWidget {
  final feedController = Get.find<FeedController>();

  Widget buildImages(List<String> images) {
    if (images.length == 1) {
      return Image.network(images[0], fit: BoxFit.cover);
    } else if (images.length == 2) {
      return Row(
        children: images.map((url) => Expanded(child: Image.network(url, fit: BoxFit.cover))).toList(),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: images.length > 4 ? 4 : images.length,
        itemBuilder: (context, index) {
          if (index == 3 && images.length > 4) {
            return Stack(
              children: [
                Image.network(images[3], fit: BoxFit.cover),
                Container(
                  color: Colors.black45,
                  alignment: Alignment.center,
                  child: Text('+${images.length - 3}', style: TextStyle(color: Colors.white, fontSize: 20)),
                )
              ],
            );
          }
          return Image.network(images[index], fit: BoxFit.cover);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feed')),
      body: feedController.reviews.isNotEmpty ? Obx(() => ListView.builder(
            itemCount: feedController.reviews.length,
            itemBuilder: (context, index) {
              final review = feedController.reviews[index];
              final commentController = feedController.commentControllers[review.id] ??= TextEditingController();
              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${review.airline} | ${review.travelClass} | ${review.departureAirport} | ${review.arrivalAirport}'),
                      SizedBox(height: 4),
                      Text(review.departureAirport),
                      SizedBox(height: 4),
                      Text('Date: ${review.travelDate}, Rating: ${review.rating}'),
                      SizedBox(height: 8),
                      buildImages(review.images!),
                      Divider(),
                      Text('Comments:'),
                      TextField(
                        controller: commentController,
                        decoration: InputDecoration(hintText: 'Write a comment'),
                        onSubmitted: (val) {
                          // feedController.postComment(review.id, val);
                          commentController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          )) : Center(child: Text("No reviews posted yet."),),
    );
  }
}