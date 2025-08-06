import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImageViewer extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final bool isIconStyle; // For small icons like logo or icon images
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
      placeholder: (context, url) => isIconStyle
          ? SizedBox(
              height: 16,
              width: 16,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  strokeWidth: 1.2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8BC34A)),
                ),
              ),
            )
          : Container(
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8BC34A)),
                ),
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
