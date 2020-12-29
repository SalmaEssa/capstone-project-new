import 'dart:async';

import 'package:axon/PODO/DynamicSection.dart';
import 'package:axon/bloc/discover/bloc.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/themes.dart';
import 'package:axon/shared_widgets/offer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class VerticalDynamicSection extends StatefulWidget {
  @override
  _VerticalDynamicSectionState createState() => _VerticalDynamicSectionState();
}

class _VerticalDynamicSectionState extends State<VerticalDynamicSection> {
  final DiscoverBloc _discoverBloc = GetIt.instance<DiscoverBloc>();

  StreamSubscription discoverSub;

  DynamicSection dynamicSection;

  @override
  void initState() {
    discoverSub = _discoverBloc.discoverStateSubject.listen((recievedState) {
      if (recievedState is VerticalDynamicSectionIs) {
        setState(() => dynamicSection = recievedState.dynamicSection);
      }
    });

    _discoverBloc.dispatch(DynamicSectionRequested(2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _hasSectionWithOffers
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 20),
                  child: Text(
                    dynamicSection.name,
                    style: AppThemes.textTheme.headline3
                        .copyWith(color: AppColors.darkBluePrimary),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: dynamicSection.offers
                      .map((offer) => OfferWidget(offer))
                      .toList(),
                ),
              ],
            ),
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
