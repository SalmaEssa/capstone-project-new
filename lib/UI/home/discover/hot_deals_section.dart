import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:axon/PODO/HotDeal.dart';
import 'package:axon/bloc/discover/bloc.dart';
import 'package:axon/main_router.gr.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/dimens.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HotDealsSection extends StatefulWidget {
  @override
  _HotDealsSectionState createState() => _HotDealsSectionState();
}

class _HotDealsSectionState extends State<HotDealsSection> {
  final DiscoverBloc _discoverBloc = GetIt.instance<DiscoverBloc>();

  StreamSubscription discoverSub;
  List<HotDeal> hotDeals = [];
  int _currentHotDeal = 0;

  @override
  void initState() {
    discoverSub = _discoverBloc.discoverStateSubject.listen((recievedState) {
      if (recievedState is HotDealsAre) {
        setState(() => hotDeals = recievedState.hotDeals);
      }
    });

    _discoverBloc.dispatch(HotDealsRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHotDealsSlider(),
        _buildHotDealsIndicator(),
      ],
    );
  }

  Widget _buildHotDealsSlider() {
    return CarouselSlider(
      items: hotDeals.map(_mapHotDealsToWidgets).toList(),
      options: CarouselOptions(
        autoPlayInterval: Duration(seconds: 4),
        viewportFraction: 1,
        height: AppDimens.hotDealImageHeight,
        onPageChanged: (int index, _) =>
            setState(() => _currentHotDeal = index),
        autoPlay: true,
        autoPlayCurve: Curves.easeIn,
        autoPlayAnimationDuration: Duration(milliseconds: 500),
      ),
    );
  }

  Widget _mapHotDealsToWidgets(HotDeal hotDeal) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => ExtendedNavigator.root.push(Routes.offerDetatilsScreen,
            arguments: OfferDetatilsScreenArguments(offerId: hotDeal.offer.id)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(hotDeal.imageLink, fit: BoxFit.fitHeight),
        ),
      ),
    );
  }

  Widget _buildHotDealsIndicator() {
    int _index;
    bool _isCurrent;

    return Wrap(
      alignment: WrapAlignment.center,
      children: hotDeals.map((url) {
        _index = hotDeals.indexOf(url);
        _isCurrent = _currentHotDeal == _index;
        return Container(
          width: _isCurrent ? 7 : 5,
          height: _isCurrent ? 7 : 5,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _isCurrent ? AppColors.white : AppColors.white.withOpacity(0.5),
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    discoverSub.cancel();
    super.dispose();
  }
}
