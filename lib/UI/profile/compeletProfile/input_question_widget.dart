import 'package:axon/resources/themes.dart';
import 'package:flutter/material.dart';

import 'package:axon/resources/colors.dart';
import 'package:axon/resources/dimens.dart';
import 'package:axon/resources/strings.dart';

class InputQuestionWidget extends StatefulWidget {
  final Function onPressed;
  TextEditingController controller = TextEditingController();
  String label;

  InputQuestionWidget(
      {@required this.controller,
      @required this.onPressed,
      @required this.label});

  @override
  _InputQuestionWidgetState createState() => _InputQuestionWidgetState();
}

class _InputQuestionWidgetState extends State<InputQuestionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 16),
      child: TextFormField(
        onChanged: widget.onPressed,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.lightTextColor,
        ),
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.lightGrayBackground,
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightGrayStroke)),
          hintText: widget.label,
          hintStyle: TextStyle(
            fontSize: 14,
            color: AppColors.lightTextColor,
          ),
        ),
      ),
    );
  }
}
