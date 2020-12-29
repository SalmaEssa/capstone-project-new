import 'dart:async';
import 'package:axon/shared_widgets/LoadingColumn.dart';
import 'package:axon/shared_widgets/RasiedButtonFilter.dart';
import 'package:flutter/material.dart';
import 'package:axon/PODO/City.dart';
import 'package:axon/PODO/Customer.dart';
import 'package:axon/PODO/Membership.dart';
import 'package:axon/PODO/Offer.dart';
import 'package:axon/PODO/Region.dart';
import 'package:axon/bloc/search/search_bloc.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/shared_widgets/select_question_widget.dart';
import 'package:axon/bloc/search/bloc.dart';
import 'package:axon/resources/strings.dart';
import 'package:get_it/get_it.dart';
import 'package:auto_route/auto_route.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Restricted screen'),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
