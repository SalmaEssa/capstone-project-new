import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:flutter/material.dart';

class SnackBarContent extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  BuildContext context;
  final String title;
  final String content;
  final bool isSuccess;

  SnackBarContent({
    this.scaffoldKey,
    this.context,
    this.title,
    @required this.content,
    this.isSuccess = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _lightColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: _mainColor,
            width: 4,
            height: 70,
          ),
          Padding(
            // padding is for the container not it's content
            padding: const EdgeInsets.all(15),
            child: Container(
              width: 30.0,
              height: 30.0,
              child: _messageIcon,
              decoration: new BoxDecoration(
                color: _mainColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _titleString,
                    style: TextStyle(
                      color: AppColors.darkBluePrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      content,
                      style: TextStyle(
                        color: AppColors.darkBluePrimary,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: _popSnackBar,
              child: Icon(Icons.close, color: _mainColor),
            ),
          ),
        ],
      ),
    );
  }

  void _popSnackBar() {
    scaffoldKey == null
        ? Scaffold.of(context).hideCurrentSnackBar()
        : scaffoldKey.currentState.hideCurrentSnackBar();
  }

  String get _titleString {
    return title ?? (isSuccess ? AppStrings.success : AppStrings.error);
  }

  Color get _mainColor {
    return isSuccess ? AppColors.greenSuccess : AppColors.redError;
  }

  Color get _lightColor {
    return isSuccess ? AppColors.greenLight : AppColors.redErrorLight;
  }

  Widget get _messageIcon {
    return isSuccess
        ? Icon(Icons.check)
        : Center(
            child: Text("!", style: TextStyle(fontWeight: FontWeight.w800)));
  }
}
