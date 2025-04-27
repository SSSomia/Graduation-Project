import 'dart:io';

import 'package:flutter/material.dart';

Widget buildImage(String imagePath) {
  if (imagePath.isEmpty) {
    // If image path is empty, show default image
    return Image.asset('assets/images/default_image.png');
  } else if (isNetworkImage(imagePath)) {
    return Image.network(
      imagePath,
      errorBuilder: (context, error, stackTrace) {
        // If network image fails, show default
        return Image.asset('assets/images/default_image.png');
      },
    );
  } else if (isFileImage(imagePath)) {
    return Image.file(File(imagePath));
  } else {
    // If none of the above, show default
    return Image.asset("assets/images/profileDefultImage/defultImage.png");
  }
}

bool isNetworkImage(String url) {
  return url.startsWith('http');
}

bool isFileImage(String path) {
  return path.startsWith('/');
}
