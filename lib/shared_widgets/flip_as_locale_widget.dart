import 'package:axon/resources/strings.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlipAsLocale extends StatelessWidget {
  final Widget child;
  FlipAsLocale({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: flipAsLocale,
      child: child,
    );
  }

  Matrix4 get flipAsLocale {
    return Matrix4.rotationY(
        AppStrings.currentCode == CodeStrings.arabicCode ? math.pi : 0);
  }
}
