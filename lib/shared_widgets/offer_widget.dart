import 'package:auto_route/auto_route.dart';
import 'package:axon/PODO/Offer.dart';
import 'package:axon/main_router.gr.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/resources/themes.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class OfferWidget extends StatelessWidget {
  final Offer offer;
  OfferWidget(this.offer);

  @override
  Widget build(BuildContext context) {
    return offer == null
        ? SizedBox()
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 35,
                  offset: Offset(0, 7),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _buildOfferImage(),
                    offer.hotDeal ? _buildHotDealTag() : SizedBox(),
                    _buildProviderInfo(),
                  ],
                ),
                _buildInfoSection(),
                DottedLine(
                    dashColor: AppColors.lightTextColor.withOpacity(0.1)),
                _buildDealRow()
              ],
            ),
          );
  }

  Widget _buildOfferImage() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
      child: Image.network(
        offer.imageLink,
        height: 130,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildHotDealTag() {
    return PositionedDirectional(
      top: 10,
      end: 0,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.dealRed,
          borderRadius:
              BorderRadiusDirectional.horizontal(start: Radius.circular(100)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          child: Text(
            AppStrings.hotDeal.toUpperCase(),
            style: TextStyle(
              color: AppColors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProviderInfo() {
    return PositionedDirectional(
      bottom: -22,
      start: 15,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 45,
            height: 45,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
            child: Image.network(offer.provider.logoLink),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: SizedBox(
              width: 250,
              child: Text(
                offer.provider.name,
                style: AppThemes.textTheme.headline4
                    .copyWith(color: AppColors.lightTextColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          start: 15, end: 15, top: 35, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              offer.name,
              style: AppThemes.textTheme.headline3
                  .copyWith(color: AppColors.blueAccent),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _buildInfoRow(Image.asset(CodeStrings.subscription), membershipText),
          _buildInfoRow(
              Image.asset(CodeStrings.categoty), offer.provider.type.name),
        ],
      ),
    );
  }

  Widget _buildInfoRow(Image imageIcon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          imageIcon,
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: SizedBox(
              width: 270,
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: AppThemes.englishAppTheme.textTheme.headline4
                    .copyWith(color: AppColors.lightTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealRow() {
    return GestureDetector(
      onTap: () => ExtendedNavigator.root.push(Routes.offerDetatilsScreen,
          arguments: OfferDetatilsScreenArguments(offerId: offer.id)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPrice(),
            Text(
              AppStrings.getOffer,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.lightTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrice() {
    return hasPrice
        ? Row(
            children: [
              Text(
                "${offer.axonPrice} ${AppStrings.egp}",
                style: AppThemes.textTheme.button
                    .copyWith(color: AppColors.dealRed),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: Text(
                  "${offer.price} ${AppStrings.egp}",
                  style: AppThemes.textTheme.headline4.copyWith(
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.lineThrough),
                ),
              ),
            ],
          )
        : SizedBox();
  }

  String get membershipText {
    bool isPayed = offer.memberships
        .every((membership) => membership.isPayed == CodeStrings.payedEnum);

    // if (!isPayed) return AppStrings.noMembership;

    return offer.memberships.fold("", (previousValue, element) {
      return previousValue == ""
          ? element.title
          : "$previousValue | ${element.title}";
    });
  }

  bool get hasPrice {
    return offer.axonPrice != null && offer.price != null;
  }
}
