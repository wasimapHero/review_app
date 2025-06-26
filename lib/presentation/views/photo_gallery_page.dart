import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/photoGallery_Controller.dart';

class PhotoGalleryPage extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const PhotoGalleryPage({
    Key? key,
    required this.images,
    required this.initialIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = Get.height;
    // 1) Put & init controller
    final photoGalleryController = Get.put(PhotoGalleryController());
    photoGalleryController.init(images, initialIndex, screenHeight, context);

    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      // 2) Reactive ListView
      body: Obx(() {
        return ListView.builder(
          controller: photoGalleryController.scrollController,
          itemCount: photoGalleryController.imgs.length,
          itemBuilder: (_, index) {
            return Container(
              height: 350,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                image: photoGalleryController.imgs[index] != null &&
                        photoGalleryController.imgs[index].isNotEmpty &&
                        Uri.tryParse(photoGalleryController.imgs[index])
                                ?.hasAbsolutePath ==
                            true
                    ? DecorationImage(
                        image: NetworkImage(photoGalleryController.imgs[index]),
                        fit: BoxFit.cover,
                        onError: (_, __) {},
                      )
                    : null,
                color:
                    Colors.grey[300], // fallback background color if no image
              ),
              child: photoGalleryController.imgs[index] == null ||
                      photoGalleryController.imgs[index].isEmpty
                  ? const Center(child: Icon(Icons.broken_image, size: 40))
                  : null,
            );
          },
        );
      }),
    );
  }
}
