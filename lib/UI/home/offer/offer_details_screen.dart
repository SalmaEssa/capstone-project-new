import 'dart:async';
import 'package:axon/PODO/Membership.dart';
import 'package:axon/main_router.gr.dart';
import 'package:axon/shared_widgets/flip_as_locale_widget.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:auto_route/auto_route.dart';
import 'package:axon/PODO/Offer.dart';
import 'package:axon/bloc/offer_details/bloc.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/resources/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class OfferDetatilsScreen extends StatefulWidget {
  final String offerId;

  OfferDetatilsScreen(this.offerId);
  @override
  _OfferDetatilsScreenState createState() => _OfferDetatilsScreenState();
}

class _OfferDetatilsScreenState extends State<OfferDetatilsScreen> {
  Offer offer;

  StreamSubscription offerDetailsSub;
  OfferDetailsBloc _offerDetailsBloc = GetIt.instance<OfferDetailsBloc>();

  @override
  void initState() {
    offerDetailsSub =
        _offerDetailsBloc.offerDetailsStateSubject.listen((recievedState) {
      if (recievedState is OfferIs) {
        setState(() => offer = recievedState.offer);
      }
    });

    initializeDateFormatting(currentDateLocale, "ar_SA");

    _offerDetailsBloc.dispatch(OfferDetailsRequested(widget.offerId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return offer == null
        ? Container()
        : Scaffold(
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 230,
                  stretch: true,
                  leading: GestureDetector(
                    onTap: () => ExtendedNavigator.root.pop(),
                    child:
                        FlipAsLocale(child: Image.asset(CodeStrings.leftArrow)),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: [
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground
                    ],
                    background: Image.network(
                      offer.imageLink,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    color: AppColors.blueAccent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            color: AppColors.whiteBackground,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                hasMembership
                                    ? _buildMembershipsBox()
                                    : SizedBox(),
                                _buildOfferInfo(),
                                _buildProviderCard(),
                                hasBranches
                                    ? _buildBranchesCard()
                                    : Container(),
                                Spacer(), // To keep the button at the bottom of the screen
                                hasMembership
                                    ? SizedBox()
                                    : _buildRedeemButton(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildMembershipsBox() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.redError,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 15),
                  child: Image.asset(
                    CodeStrings.subscription,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  AppStrings.membershipRequired,
                  style: AppThemes.englishAppTheme.textTheme.subtitle1
                      .copyWith(color: AppColors.white),
                ),
                Spacer(),
                FlipAsLocale(
                  child: Image.asset(
                    CodeStrings.smallRightArrow,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              AppStrings.membershipRequiredHint,
              style: AppThemes.englishAppTheme.textTheme.subtitle1
                  .copyWith(color: AppColors.white),
            ),
          ),
          Wrap(
            children: _mapMembershipsToWidgets(),
          ),
        ],
      ),
    );
  }

  List<Widget> _mapMembershipsToWidgets() {
    return offer.memberships
        .map((membership) => _buildMembershipElement(membership))
        .toList();
  }

  Widget _buildMembershipElement(Membership membership) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 10, end: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          membership.title,
          style: AppThemes.englishAppTheme.textTheme.bodyText2,
        ),
      ),
    );
  }

  Widget _buildOfferInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOfferValidity(),
              _buildOfferName(),
              _buildOfferDescription(),
              _buildOfferPrice(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOfferValidity() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        "${AppStrings.validUntil} $offerDate",
        style: AppThemes.englishAppTheme.textTheme.bodyText1
            .copyWith(color: AppColors.goldAccent),
      ),
    );
  }

  Widget _buildOfferName() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        offer.name,
        style: AppThemes.englishAppTheme.textTheme.headline3
            .copyWith(color: AppColors.darkBluePrimary),
      ),
    );
  }

  Widget _buildOfferDescription() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        offer.description,
        style: AppThemes.englishAppTheme.textTheme.bodyText1,
      ),
    );
  }

  Widget _buildOfferPrice() {
    return hasPrice
        ? Row(
            children: [
              Text(
                "${offer.axonPrice} ${AppStrings.egp}",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: AppColors.dealRed,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: Text(
                  "${offer.price} ${AppStrings.egp}",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.lightTextColor,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            ],
          )
        : SizedBox();
  }

  Widget _buildProviderCard() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(6)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: Container(
                width: 55,
                height: 55,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(3)),
                child: Image.network(offer.provider.logoLink),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.provider.name,
                  style: AppThemes.englishAppTheme.textTheme.subtitle1,
                ),
                Text(
                  offer.provider.type.name,
                  style: AppThemes.englishAppTheme.textTheme.bodyText1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBranchesCard() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 10),
      child: FlatButton(
        onPressed: () => ExtendedNavigator.root.push(
            Routes.providerBranchesScreen,
            arguments: ProviderBranchesScreenArguments(offerId: offer.id)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: Image.asset(CodeStrings.locationIcon),
            ),
            Text(
              AppStrings.availableBranches,
              style: AppThemes.englishAppTheme.textTheme.subtitle1,
            ),
            Spacer(),
            FlipAsLocale(
              child: Image.asset(
                CodeStrings.smallRightArrow,
                color: AppColors.lightTextColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRedeemButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: FlatButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        color: AppColors.greenAccent,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          // A row with one element is a dirty way to center the element
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.redeemOffer,
              style: AppThemes.englishAppTheme.textTheme.button
                  .copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }

  bool get hasMembership {
    return offer.memberships != null && offer.memberships.isNotEmpty;
  }

  String get currentDateLocale {
    return AppStrings.currentCode == CodeStrings.arabicCode ? "ar_SA" : "en_US";
  }

  String get offerDate {
    String monthName =
        DateFormat('LLL', currentDateLocale).format(offer.dueDate);
    String date = DateFormat('dd, y', "en_US")
        .format(offer.dueDate); //Date should always be in english characters

    return "$monthName $date";
  }

  bool get hasPrice {
    return offer.axonPrice != null && offer.price != null;
  }

  bool get hasBranches {
    return (offer?.branches?.isNotEmpty) ?? false;
  }

  @override
  void dispose() {
    offerDetailsSub.cancel();
    super.dispose();
  }
}
