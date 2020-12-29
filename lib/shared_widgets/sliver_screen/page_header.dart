import 'dart:math';

import 'package:axon/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PageHeader implements SliverPersistentHeaderDelegate {
  final double minExtent = 110;
  final double maxExtent = 340;
  final Widget editWidget;
  final Widget titleWidget;
  final Widget subtitleWidget;
  final double shrinkOpacityFactor;

  PageHeader(this.editWidget, this.titleWidget, this.subtitleWidget,
      this.shrinkOpacityFactor);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.clip,
      // fit: StackFit.expand,
      children: [
        Container(color: AppColors.blueAccent),
        editWidget ?? Container(),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 25),
          child: titleWidget ?? Container(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25, top: 15),
          child: Opacity(
            opacity: logoNameOpacity(shrinkOffset),
            child: subtitleWidget == null
                ? Container()
                : FittedBox(child: subtitleWidget),
          ),
        )
      ],
    );
  }

  double logoNameOpacity(double shrinkOffset) {
    double value =
        (1.0 - max(0.0, shrinkOffset * (shrinkOpacityFactor ?? 1)) / maxExtent);
    if (value < 0.6) return 0;
    return value;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
      null;

  @override
  TickerProvider get vsync => null;
}
