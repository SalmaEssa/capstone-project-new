import 'package:flutter/material.dart';

import 'package:axon/resources/colors.dart';
import 'package:axon/resources/dimens.dart';

class ButtonWidget extends StatefulWidget {
  final GestureTapCallback onPressed;
  bool ready;
  bool change;
  ButtonWidget(
      {@required this.onPressed, this.ready = false, this.change = false});

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
          width: 70,
          height: 70,
          child: (widget.change
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      AppColors.purplePrimary),
                )
              : Container())),
      _buildButton(),
    ]);
  }

  Widget _buildButton() {
    return Container(
      margin: EdgeInsets.all(6),
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            ((widget.ready || widget.change)
                ? AppColors.babyBlue
                : AppColors.lightGrayStroke),
            ((widget.ready || widget.change)
                ? AppColors.blue
                : AppColors.lightGrayStroke)
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
      ),
      child: FlatButton(
        child: Icon(
          Icons.arrow_forward,
          color: ((widget.ready || widget.change)
              ? AppColors.white
              : AppColors.darkBluePrimary),
        ),
        onPressed: () {
          widget.onPressed();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
        ),
      ),
    );
  }
}
