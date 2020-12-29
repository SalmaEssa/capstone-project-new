import 'package:axon/resources/themes.dart';
import 'package:flutter/material.dart';

import 'package:axon/resources/colors.dart';
import 'package:axon/resources/dimens.dart';
import 'package:axon/resources/strings.dart';

class InputWidget extends StatefulWidget {
  String title;
  Function onChange;
  TextEditingController controller ;
  String label;
  bool changeColorBorder;
  InputWidget({@required  this.title,@required  this.label,@required this.onChange,@required this.controller,this.changeColorBorder=false});

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
 

  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      
        crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      
      Container(
          child:Text(widget.title,style: Theme.of(context).textTheme.headline3,),)
    ,_buildInputQuestionWidget()]);
  }

 Widget _buildInputQuestionWidget() {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 16),
      child: TextFormField(
         autofocus: false,
        onChanged: widget.onChange,
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
              borderSide: BorderSide(color:widget.changeColorBorder?AppColors.redError: AppColors.lightGrayStroke)),
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
