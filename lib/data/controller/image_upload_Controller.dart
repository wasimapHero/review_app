import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ImageUploadController extends GetxController {
  final picker = ImagePicker();
  final RxList<File> selectedImages = <File>[].obs;
  final RxList<String> imageUrls = <String>[].obs;
  final RxList<String> fetchedImageUrls = <String>[].obs;

  // ✅ Pick multiple images from gallery
  Future<void> pickMultipleImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      print('picked images recieved, ${pickedFiles[0].path}');
      selectedImages.value = pickedFiles.map((f) => File(f.path)).toList();
    }
  }

  // Upload images and get their Supabase URLs
  Future<List<String>> uploadImagesToSupabase(String image_review_common_id) async {
    final bucket = Supabase.instance.client.storage.from('review-images');

    for (var imageFile in selectedImages) {
      final fileName =
          '${const Uuid().v4()}${extensionFromPath(imageFile.path)}';
      final fileName_ = fileName.startsWith('/') ? fileName.substring(1) : fileName;
      final filePath = 'reviews/$image_review_common_id/$fileName_';
      final bytes = await imageFile.readAsBytes();
      final contentType =
          lookupMimeType(imageFile.path) ?? 'application/octet-stream';

          //
          print('fileName :  $fileName');
          print('filePath :  $filePath');

      await bucket.uploadBinary(
        filePath,
        bytes,
        fileOptions: FileOptions(
          upsert: true,
          contentType: contentType,
        ),
      );

      final publicUrl = bucket.getPublicUrl(filePath);
      imageUrls.add(publicUrl);
    }

    return imageUrls;
  }

  // Optional helper if want to keep the extension
  String extensionFromPath(String path) {
    return path.contains('.') ? '.${path.split('.').last}' : '.jpg';
  }

  // Optional: clear images
  void clearImages() {
    selectedImages.clear();
  }

  // fetch Images according to image_review_common_id
  

  Future<void> fetchReviewImages(String imageReviewCommonId) async {
    try {
      final bucket = Supabase.instance.client.storage.from('review-images');
  final prefix = 'reviews/$imageReviewCommonId';

  // Fetch all files under the specific folder
  final List<FileObject> files = await bucket.list(path: prefix);

  // Convert file paths to public URLs
  final List<String> urls = files
      .map((file) => bucket.getPublicUrl('$prefix/${file.name}'))
      .toList();


      fetchedImageUrls.assignAll(urls);
    } catch (e) {
      print('Error fetching review images: $e');
    }
  }
}
