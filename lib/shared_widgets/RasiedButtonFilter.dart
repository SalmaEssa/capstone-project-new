
import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:axon/resources/colors.dart';

import 'package:axon/resources/strings.dart';

class RaisedButtonFilter extends StatelessWidget {
  String label; String filterName; Function onpressed;String selectedFilter;
  RaisedButtonFilter({this.label,this.onpressed,this.filterName,this.selectedFilter});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: getActiveColor(filterName),
      width: 190,
      height: 55,
      child: RaisedButton(
          elevation: 0,
          color: getActiveColor(filterName),
          onPressed: onpressed,
          child: Center(
              child: Text(
            label,
            style: TextStyle(
              color: getTextActiveColor(filterName),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ))),
    );
  }


  
  Color getActiveColor(String nameOfFilter) {
    if (nameOfFilter == selectedFilter) {
      return AppColors.purplePrimary;
    }
    return AppColors.lightGrayBackground;
  }

  Color getTextActiveColor(String nameOfFilter) {
    if (nameOfFilter == selectedFilter) {
      return AppColors.white;
    }
    return AppColors.purplePrimary;
  }
}