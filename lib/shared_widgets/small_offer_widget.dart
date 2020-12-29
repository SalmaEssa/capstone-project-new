import 'package:axon/PODO/Offer.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/resources/themes.dart';
import 'package:flutter/material.dart';

class SmallOfferWidget extends StatelessWidget {
  final Offer offer;
  SmallOfferWidget(this.offer);

  @override
  Widget build(BuildContext context) {
    return offer == null
        ? SizedBox()
        : Container(
            width: 245,
            margin: const EdgeInsetsDirectional.only(
                start: 15, end: 15, top: 15, bottom: 25),
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
                    hasPrice ? _buildPriceTag() : SizedBox(),
                  ],
                ),
                _buildInfoSection(),
              ],
            ),
          );
  }

  Widget _buildOfferImage() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
      child: Image.network(
        offer.imageLink,
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildPriceTag() {
    return PositionedDirectional(
      end: 10,
      top: 105,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.blueAccent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "${offer.axonPrice} ${AppStrings.egp}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProviderInfo(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              offer.name,
              style: AppThemes.textTheme.headline3
                  .copyWith(color: AppColors.darkBluePrimary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _buildInfoRow(),
        ],
      ),
    );
  }

  Widget _buildProviderInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            offer.provider.name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.greenAccent,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            offer.provider.type.name,
            style: AppThemes.textTheme.headline4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(CodeStrings.subscription, color: AppColors.blueAccent),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: Text(
              membershipText,
              style: AppThemes.textTheme.headline4
                  .copyWith(color: AppColors.blueAccent),
            ),
          ),
        ],
      ),
    );
  } 

  String get membershipText {
    if (offer.memberships.length==0) return AppStrings.noMembership;
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
