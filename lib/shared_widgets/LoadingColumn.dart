
import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:axon/resources/colors.dart';

import 'package:axon/resources/strings.dart';

class LoadingColumn extends StatelessWidget {
  final Widget widget;
  LoadingColumn(this.widget);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
      widget,
            Expanded(
                child: Center(
              child: Container(
                  width: 85,
                  height: 85,
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        AppColors.purplePrimary),
                  )),
            )),
          ],
        ),
      ),
    );
  }
}