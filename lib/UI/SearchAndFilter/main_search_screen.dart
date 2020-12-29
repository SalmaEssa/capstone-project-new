import 'dart:async';

import 'package:axon/PODO/Offer.dart';
import 'package:axon/PODO/ProviderType.dart';
import 'package:axon/bloc/search/search_bloc.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/shared_widgets/ButtonWidget.dart';
import 'package:axon/shared_widgets/CategoryRowElement.dart';
import 'package:axon/shared_widgets/EmptyView.dart';
import 'package:axon/shared_widgets/LoadingColumn.dart';
import 'package:flutter/material.dart';
import 'package:axon/bloc/search/bloc.dart';
import 'package:axon/resources/strings.dart';
import 'package:get_it/get_it.dart';
import 'package:auto_route/auto_route.dart';
import 'package:axon/main_router.gr.dart';
import 'package:axon/shared_widgets/offer_widget.dart';

class MainSearchScreen extends StatefulWidget {
  @override
  _MainSearchScreenState createState() => _MainSearchScreenState();
}

class _MainSearchScreenState extends State<MainSearchScreen> {
  SearchBloc _searchBloc = GetIt.instance<SearchBloc>();
  StreamSubscription _streamSubscription;
  List<Offer> offers = [];
  TextEditingController controller = TextEditingController();
  bool loading = false;
  bool categoryView = true;
  String selectedFiltterCategory = CodeStrings.all;
  String selectedCategoryId;
  String requiredValue;
  List<ProviderType> _providerTypes = [];
  _ViewsElement selectedViewElement = _ViewsElement.Loading;
  @override
  void initState() {
    categoryView = true;
    selectedCategoryId = null;
    selectedFiltterCategory = CodeStrings.all;
    _streamSubscription = _searchBloc.searchSubject.listen((state) {
      if (state is OffersAre) {
        setState(() {
          if (state.offers != null) {
            offers = [];
            offers = state.offers;
            selectedViewElement = _ViewsElement.OffersCards;
          }
        });
      }
      if (state is ProviderTypesCategoriesAre) {
        setState(() {
          _providerTypes = state.providerTypers;
        });
      }
      if (state is InitialCategoryView) {
        setState(() {
          selectedViewElement = _ViewsElement.CategoryView;
        });
      }
      if (state is UpdateSelectedCategoryFromDiscovery) {
        setState(() {
          if (state.providerTyperId != CodeStrings.all) {
            ProviderType selectedProvider = _providerTypes
                .firstWhere((element) => element.id == state.providerTyperId);
            selectedFiltterCategory = selectedProvider.name;
            selectedCategoryId = selectedProvider.id;
          }
          if (state.providerTyperId == CodeStrings.all) {
            selectedFiltterCategory = CodeStrings.all;
            selectedCategoryId = null;
          }
        });
      }
    });
    _searchBloc.dispatch(LaunchMainSearchScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          color: AppColors.blueAccent,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: AppColors.white),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          ExtendedNavigator.root.pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.purplePrimary,
                        ),
                      ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsetsDirectional.only(end: 16),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: AppColors.lightGrayStroke,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                end: 14),
                                        child: Icon(
                                          Icons.search,
                                          color: AppColors.lightTextColor,
                                        ),
                                      ),
                                      FittedBox(
                                        child: Container(
                                          width: 180,
                                          child: TextFormField(
                                            controller: controller,
                                            onChanged: (String value) {
                                              setState(() {
                                                selectedViewElement =
                                                    _ViewsElement.Loading;
                                                requiredValue = value;
                                              });
                                              if (value.length > 2) {
                                                _searchBloc.dispatch(
                                                    SearchByProviderNameOfOffer(
                                                        requiredValue,
                                                        selectedCategoryId));
                                              }
                                              if (value.length == 0) {
                                                setState(() {
                                                  selectedViewElement =
                                                      _ViewsElement.CategoryView;
                                                });
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: AppStrings
                                                  .whatareyoulookingfor,
                                              hintStyle: TextStyle(
                                                color: AppColors.lightTextColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        ExtendedNavigator.root.push(Routes.filterScreen);
                                      },
                                      icon: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Image.asset(CodeStrings.vector),
                                      )),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                  getViews(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getViews() {
    switch (selectedViewElement) {
      case _ViewsElement.OffersCards:
        return _buildListoffersCards();
        break;
      case _ViewsElement.Loading:
        return LoadingColumn(_providerTypes.length != 0
            ? _buildCategoriesFilterRow()
            : Container());
        break;
      case _ViewsElement.CategoryView:
        return _buildCategoryView();
        break;
    }
  }

  Widget _buildListoffersCards() {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            _buildCategoriesFilterRow(),
            ((offers.length == 0) ? EmptyView() : _buildOffersList()),
          ],
        ),
      ),
    );
  }

  Widget _buildOffersList() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding:
              const EdgeInsetsDirectional.only(top: 25, start: 16, end: 16),
          child: Column(
              children: offers.map((offer) => OfferWidget(offer)).toList()),
        ),
      ),
    );
  }

  Widget _buildCategoryView() {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              _buildCategoriesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 25, start: 15, bottom: 16),
      child: Text(
        AppStrings.bROWSECATEGORIES,
        style: TextStyle(
          color: AppColors.blueAccent,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCategoriesList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _providerTypes?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return CategoryRowElement(
          onpressed: () {
            _searchBloc
                .dispatch(GetFilterWithCategory(_providerTypes[index].id));
            setState(() {
              selectedFiltterCategory = _providerTypes[index].name;
              selectedCategoryId = _providerTypes[index].id;
            });
          },
          image: _providerTypes[index].imageLink,
          title: _providerTypes[index].name,
        );
      },
    );
  }

  Widget _buildCategoriesFilterRow() {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(maxHeight: 100),
      child: Container(
        height: 70,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_buildAllElement(), _buildCategoriesFilterList()],
          ),
        ),
      ),
    );
  }

  Widget _buildAllElement() {
    return FlatButton(
      onPressed: () {
        setState(() {
          selectedFiltterCategory = CodeStrings.all;
          selectedCategoryId = null;
          _searchBloc.dispatch(
              SearchByProviderNameOfOffer(requiredValue, selectedCategoryId));
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: getActiveColor(CodeStrings.all),
          border: Border.all(
            color: getActiveColor(CodeStrings.all),
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          AppStrings.allCapital,
          style: TextStyle(
            color: getTextActiveColor(CodeStrings.all),
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
  Widget _buildCategoriesFilterList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: _providerTypes?.length,
      itemBuilder: (BuildContext context, int index) {
        return FlatButton(
          onPressed: () {
            setState(() {
              selectedFiltterCategory = _providerTypes[index].name;
              selectedCategoryId = _providerTypes[index].id;
              if (requiredValue == null) {
                _searchBloc
                    .dispatch(GetFilterWithCategory(_providerTypes[index].id));
              } else {
                _searchBloc.dispatch(SearchByProviderNameOfOffer(
                    requiredValue, _providerTypes[index].id));
              }
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: getActiveColor(_providerTypes[index].name),
              border: Border.all(
                color: getActiveColor(_providerTypes[index].name),
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              _providerTypes[index].name,
              style: TextStyle(
                color: getTextActiveColor(_providerTypes[index].name),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      },
    );
  }
  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
  Color getActiveColor(String nameOfFilter) {
    if (nameOfFilter == selectedFiltterCategory) {
      return AppColors.purplePrimary;
    }
    return AppColors.lightGrayStroke;
  }

  Color getTextActiveColor(String nameOfFilter) {
    if (nameOfFilter == selectedFiltterCategory) {
      return AppColors.white;
    }
    return AppColors.lightTextColor;
  }
}

enum _ViewsElement {
  CategoryView,
  OffersCards,
  Loading,
}
