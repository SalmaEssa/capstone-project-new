import 'package:auto_route/auto_route.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/resources/themes.dart';
import 'package:flutter/material.dart';

class CategoryRowElement extends StatelessWidget {
  final String title;
  final String image;
Function onpressed;
  CategoryRowElement({
    @required this.title,
    @required this.image,
  @required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      width: double.infinity,
      child: FlatButton(
     
        onPressed: onpressed,
    
       
        child: _buildContent(),
      ),
    );
  }







  Widget _buildContent() {
    return Row(
      children: <Widget>[
        buildSmallImage(),
        Expanded(
          child: Text(this.title,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.darkBluePrimary,
                fontWeight: FontWeight.w600,
              )),
        ),
        Container(
          
                child: Icon(Icons.arrow_forward_ios,
                    color: AppColors.lightTextColor,))
      ],
    );
  }

  Widget buildSmallImage() {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 12),
    
     
     
      child:   Image.network(
            this.image,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
    );
  }
}
