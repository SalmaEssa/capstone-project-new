import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final Widget errorWidget;
  final Widget placeHolder;
  final Widget Function(BuildContext context, ImageProvider image) imageBuilder;
  final double loadingStrokeWidth;

  CustomNetworkImage({
    @required this.url,
    @required this.errorWidget,
    this.placeHolder,
    this.imageBuilder,
    this.loadingStrokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? "",
      fadeInCurve: Curves.easeIn,
      fadeInDuration: Duration(milliseconds: 800),
      fit: BoxFit.cover,
      imageBuilder: imageBuilder,
      errorWidget: (BuildContext context, String string, _) {
        return errorWidget;
      },
      placeholder: (BuildContext context, String string) {
        return placeHolder ??
            CircularProgressIndicator(strokeWidth: loadingStrokeWidth ?? 4);
      },
    );
  }
}
