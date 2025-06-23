import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ImageInfoController extends GetxController {

  /// Returns a Future that completes with the intrinsic width & height
/// of the image at [url].
Future<ui.Image> _loadImageAndGetInfo(String url) {
  final completer = Completer<ui.Image>();
  // Create the image provider
  final provider = NetworkImage(url);

  // Resolve it to an ImageStream
  final stream = provider.resolve(const ImageConfiguration());
  // Listen for the first frame
  late final ImageStreamListener listener;
  listener = ImageStreamListener((ImageInfo info, bool _) {
    completer.complete(info.image);
    // Clean up
    stream.removeListener(listener);
  }, onError: (dynamic error, _) {
    completer.completeError(error);
    stream.removeListener(listener);
  });
  stream.addListener(listener);

  return completer.future;
}

Future<int> getImageHeight(String url) async {
  try {
    final ui.Image image = await _loadImageAndGetInfo(url);
    print('Image width: ${image.width}');
    print('Image height: ${image.height}');
    return image.height;
  } catch (e) {
    print('Failed to load image: $e');
    return 0;
  }
}

}