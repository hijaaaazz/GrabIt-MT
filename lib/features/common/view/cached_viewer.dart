import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CachedImageViewer extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final bool isIconStyle;
  final double errorIconSize;

  const CachedImageViewer({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.isIconStyle = false,
    this.errorIconSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: width ?? double.infinity,
          height: height ?? 200,
          color: Colors.white,
        ),
      ),
      errorWidget: (context, url, error) => isIconStyle
          ? const Icon(Icons.broken_image, size: 16, color: Colors.grey)
          : Container(
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: Icon(
                Icons.broken_image,
                color: Colors.grey,
                size: errorIconSize,
              ),
            ),
    );
  }
}
