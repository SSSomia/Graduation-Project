// import 'dart:io';
// import 'package:http/http.dart' as http;

// Future<List<File>> mergeImages({
//   required List<String> existingImageUrls,
//   required List<File> newPickedImages,
// }) async {
//   List<File> allImages = [];

//   // Step 1: Download existing images from URLs
//   for (var url in existingImageUrls) {
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         // Create a temporary file from response bytes
//         final tempDir = await getTemporaryDirectory();
//         final fileName = path.basename(url);
//         final file = File('${tempDir.path}/$fileName');
//         await file.writeAsBytes(response.bodyBytes);
//         allImages.add(file);
//       }
//     } catch (e) {
//       print('Failed to download image from $url: $e');
//     }
//   }

//   // Step 2: Add newly picked images
//   allImages.addAll(newPickedImages);

//   return allImages;
// }
