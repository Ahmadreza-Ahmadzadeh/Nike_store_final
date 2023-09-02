import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class loadingImageServer extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;

  const loadingImageServer({required this.imageUrl, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
    );
    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius, child: image);
    } else {
      return image;
    }
  }
}
