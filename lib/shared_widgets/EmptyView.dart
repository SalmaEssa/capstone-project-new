
import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:axon/resources/colors.dart';

import 'package:axon/resources/strings.dart';

class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 150,
          color: AppColors.white,
          child: FlareActor(CodeStrings.searchEmpty,
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: "move"),
        ),
        new Container(
            child: Text(AppStrings.wecouldnotfindanyoffersmatchingyoursearch)),
      ],
    )));
  }
}