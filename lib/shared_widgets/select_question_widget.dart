import 'package:axon/resources/themes.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/dimens.dart';
import 'package:axon/resources/strings.dart';

class SelectQuestionWidget extends StatefulWidget {
  final Function onPressed;
  String selectedItem;
  String label;
  List items;
  double padding;
  Key key;
  SelectQuestionWidget(
      {@required this.items,
      @required this.onPressed,
      @required this.label,
      @required this.selectedItem,
      this.padding,
      this.key});

  @override
  _SelectQuestionWidgetState createState() => _SelectQuestionWidgetState();
}

class _SelectQuestionWidgetState extends State<SelectQuestionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsetsDirectional.only(top: widget.padding),
      alignment: AlignmentDirectional.center,
      margin: EdgeInsetsDirectional.only(top: 16),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrayStroke),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: AppColors.lightGrayBackground),
      child: SearchableDropdown.single(
        key: widget.key,
        displayClearIcon: false,
        underline: Padding(
          padding: EdgeInsets.all(1),
        ),
        style: TextStyle(
          color: AppColors.darkBluePrimary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        icon: Icon(Icons.keyboard_arrow_down),
        hint: Text(
          widget.label,
          style: TextStyle(
            color: AppColors.darkBluePrimary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        items: widget.items.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.name),
            value: item.name,
          );
        }).toList(),
        value: widget.selectedItem,
        onChanged: widget.onPressed,
        isExpanded: true,
      ),
    );
  }
}
