import 'dart:async';

import 'package:axon/PODO/DynamicSection.dart';
import 'package:axon/bloc/discover/bloc.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/themes.dart';
import 'package:axon/shared_widgets/small_offer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HorizontalDynamicSection extends StatefulWidget {
  @override
  _HorizontalDynamicSectionState createState() =>
      _HorizontalDynamicSectionState();
}

class _HorizontalDynamicSectionState extends State<HorizontalDynamicSection> {
  final DiscoverBloc _discoverBloc = GetIt.instance<DiscoverBloc>();

  StreamSubscription discoverSub;

  DynamicSection dynamicSection;

  @override
  void initState() {
    discoverSub = _discoverBloc.discoverStateSubject.listen((recievedState) {
      if (recievedState is HorizontalDynamicSectionIs) {
        setState(() => dynamicSection = recievedState.dynamicSection);
      }
    });

    _discoverBloc.dispatch(DynamicSectionRequested(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _hasSectionWithOffers
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 15, top: 20, bottom: 15),
                child: Text(
                  dynamicSection.name,
                  style: AppThemes.textTheme.headline3
                      .copyWith(color: AppColors.darkBluePrimary),
                ),
              ),
              Container(
                height: 320,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: dynamicSection.offers
                      .map((offer) => SmallOfferWidget(offer))
                      .toList(),
                ),
              ),
            ],
          )
        : SizedBox();
  }

  bool get _hasSectionWithOffers {
    return dynamicSection?.offers != null &&
        (dynamicSection?.offers?.isNotEmpty ?? false);
  }

  @override
  void dispose() {
    discoverSub.cancel();
    super.dispose();
  }
}
