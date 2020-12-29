import 'dart:async';

import 'package:axon/PODO/ProviderType.dart';
import 'package:axon/bloc/discover/bloc.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/resources/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProviderTypesSection extends StatefulWidget {
  @override
  ProviderTypesSectionState createState() => ProviderTypesSectionState();
}

class ProviderTypesSectionState extends State<ProviderTypesSection> {
  DiscoverBloc _discoverBloc = GetIt.instance<DiscoverBloc>();
  StreamSubscription discoverSub;

  List<ProviderType> _providerTypes = [];

  @override
  void initState() {
    discoverSub = _discoverBloc.discoverStateSubject.listen((recievedState) {
      if (recievedState is ProviderTypesAre) {
        setState(() => _providerTypes = recievedState.providerTypers);
      }
    });

    _discoverBloc.dispatch(ProviderTypesRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      color: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleWidget(),
          _buildCategoriesScollBox(),
        ],
      ),
    );
  }

  Widget _buildCategoriesScollBox() {
    return Container(
      height: 280,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Wrap(
          runSpacing: 55,
          alignment: WrapAlignment.start,
          direction: Axis.vertical,
          children: _mapTypesToWidgets(),
        ),
      ),
    );
  }

  List<Widget> _mapTypesToWidgets() {
    return _providerTypes
        .map((ProviderType type) => _buildCategoryWidget(type))
        .toList();
  }

  Widget _buildTitleWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        AppStrings.ourCategories,
        style: AppThemes.textTheme.headline3
            .copyWith(color: AppColors.darkBluePrimary),
      ),
    );
  }

  Widget _buildCategoryWidget(ProviderType type) {
    return FlatButton(
       onPressed: (){
          
            _discoverBloc.dispatch(GetFilterProviderType(type.id));
          },
          child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child:Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                type.imageLink,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: Text(
                  type.name,
                  style: AppThemes.textTheme.subtitle1
                      .copyWith(color: AppColors.darkBluePrimary),
                ),
              ),
            ],
          
        ),
      ),
    );
  }

  @override
  void dispose() {
    discoverSub.cancel();
    super.dispose();
  }
}
