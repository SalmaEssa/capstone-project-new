import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:axon/PODO/Branch.dart';
import 'package:axon/bloc/offer_details/bloc.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/resources/themes.dart';
import 'package:axon/shared_widgets/flip_as_locale_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProviderBranchesScreen extends StatefulWidget {
  final String offerId;
  ProviderBranchesScreen(this.offerId);

  @override
  _ProviderBranchesScreenState createState() => _ProviderBranchesScreenState();
}

class _ProviderBranchesScreenState extends State<ProviderBranchesScreen> {
  List<Branch> branches;

  StreamSubscription offerDetailsSub;
  OfferDetailsBloc _offerDetailsBloc = GetIt.instance<OfferDetailsBloc>();

  @override
  void initState() {
    offerDetailsSub =
        _offerDetailsBloc.offerDetailsStateSubject.listen((recievedState) {
      if (recievedState is OfferProviderBranchesAre) {
        setState(() => branches = recievedState.branches);
      }
    });

    _offerDetailsBloc.dispatch(OfferpProviderBranchesRequested(widget.offerId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueAccent,
      appBar: AppBar(
        leading: _buildBackButton(),
        title: Text(
          AppStrings.availableBranches,
          style: AppThemes.englishAppTheme.textTheme.headline3
              .copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.blueAccent,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          color: AppColors.whiteBackground,
        ),
        child: _hasBranchers
            ? _buildBranchesCards()
            : Center(child: _buildProgressWidget()),
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => ExtendedNavigator.root.pop(),
      child: FlipAsLocale(
          child: Image.asset(
        CodeStrings.leftArrow,
        color: AppColors.white,
      )),
    );
  }

  Widget _buildProgressWidget() {
    return Container(
      width: 85,
      height: 85,
      child: CircularProgressIndicator(
        strokeWidth: 5,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.purplePrimary),
      ),
    );
  }

  Widget _buildBranchesCards() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
            children: _mapBranchesToWidgets(),
          ),
        ),
      ),
    );
  }

  List<Widget> _mapBranchesToWidgets() {
    return branches?.map((branch) => _buildBranchesCardElement(branch)).toList();
  }

  Widget _buildBranchesCardElement(Branch branch) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Align(
        alignment: AlignmentDirectional.topStart,
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                branch.name,
                style: AppThemes.englishAppTheme.textTheme.bodyText1
                    .copyWith(color: AppColors.darkBluePrimary),
              ),
            ),
            Text(
              branch?.address??"",
              style: AppThemes.englishAppTheme.textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }

  bool get _hasBranchers {
    return branches != null && branches.isNotEmpty;
  }

  @override
  void dispose() {
    offerDetailsSub.cancel();
    super.dispose();
  }
}
