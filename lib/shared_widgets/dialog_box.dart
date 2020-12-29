import 'package:auto_route/auto_route.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/resources/themes.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final String title;
  final String submitText;
  final bool alertColors;
  DialogBox({
    @required this.title,
    @required this.submitText,
    this.alertColors = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: AppThemes.englishAppTheme.textTheme.button
                  .copyWith(color: AppColors.darkBluePrimary),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                  onPressed: () => ExtendedNavigator.of(context).pop(false),
                  child: Text(
                    AppStrings.cancel.toUpperCase(),
                    style: AppThemes.englishAppTheme.textTheme.button
                        .copyWith(color: AppColors.greenAccent),
                  ),
                ),
                FlatButton(
                  onPressed: () => ExtendedNavigator.of(context).pop(true),
                  child: Text(
                    submitText.toUpperCase(),
                    style: AppThemes.englishAppTheme.textTheme.button
                        .copyWith(color: AppColors.redError),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
