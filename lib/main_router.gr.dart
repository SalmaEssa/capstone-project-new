// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'UI/Auth/auth_screen.dart';
import 'UI/Auth/verification_screen.dart';
import 'UI/SearchAndFilter/filter_screen.dart';
import 'UI/SearchAndFilter/main_search_screen.dart';
import 'UI/home/offer/offer_details_screen.dart';
import 'UI/home/offer/provider_branches_screen.dart';
import 'UI/home/screen_wrapper.dart';
import 'UI/home/settings_screen.dart';
import 'UI/profile/change_phone_screen.dart';
import 'UI/profile/compeletProfile/complete_profile_screen.dart';
import 'UI/profile/editPofile/edit_profile_screen.dart';
import 'UI/profile/verify_change_phone_screen.dart';
import 'UI/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String authScreen = '/auth-screen';
  static const String verificationScreen = '/verification-screen';
  static const String screenWrapper = '/screen-wrapper';
  static const String settingsScreen = '/settings-screen';
  static const String editProfileScreen = '/edit-profile-screen';
  static const String completeProfileScreen = '/complete-profile-screen';
  static const String mainSearchScreen = '/main-search-screen';
  static const String filterScreen = '/filter-screen';

  static const String offerDetatilsScreen = '/offer-detatils-screen';
  static const String changePhoneScreen = '/change-phone-screen';
  static const String verifyChangePhoneScreen = '/verify-change-phone-screen';
  static const String providerBranchesScreen = '/provider-branches-screen';
  static const all = <String>{
    splashScreen,
    authScreen,
    verificationScreen,
    screenWrapper,
    settingsScreen,
    editProfileScreen,
    completeProfileScreen,
    mainSearchScreen,
    filterScreen,
    offerDetatilsScreen,
    changePhoneScreen,
    verifyChangePhoneScreen,
    providerBranchesScreen,
  };
}

class MainRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.authScreen, page: AuthScreen),
    RouteDef(Routes.verificationScreen, page: VerificationScreen),
    RouteDef(Routes.screenWrapper, page: ScreenWrapper),
    RouteDef(Routes.settingsScreen, page: SettingsScreen),
    RouteDef(Routes.editProfileScreen, page: EditProfileScreen),
    RouteDef(Routes.completeProfileScreen, page: CompleteProfileScreen),
    RouteDef(Routes.mainSearchScreen, page: MainSearchScreen),
    RouteDef(Routes.filterScreen, page: FilterScreen),
    RouteDef(Routes.editProfileScreen, page: EditProfileScreen),
    RouteDef(Routes.offerDetatilsScreen, page: OfferDetatilsScreen),
    RouteDef(Routes.changePhoneScreen, page: ChangePhoneScreen),
    RouteDef(Routes.verifyChangePhoneScreen, page: VerifyChangePhoneScreen),
    RouteDef(Routes.providerBranchesScreen, page: ProviderBranchesScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    AuthScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AuthScreen(),
        settings: data,
      );
    },
    VerificationScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerificationScreen(),
        settings: data,
      );
    },
    ScreenWrapper: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ScreenWrapper(),
        settings: data,
      );
    },
    SettingsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsScreen(),
        settings: data,
      );
    },
    EditProfileScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditProfileScreen(),
        settings: data,
      );
    },
    CompleteProfileScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CompleteProfileScreen(),
        settings: data,
      );
    },
    MainSearchScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MainSearchScreen(),
        settings: data,
      );
    },
    FilterScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => FilterScreen(),
        settings: data,
      );
    },
    OfferDetatilsScreen: (data) {
      final args = data.getArgs<OfferDetatilsScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => OfferDetatilsScreen(args.offerId),
        settings: data,
      );
    },
    ChangePhoneScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChangePhoneScreen(),
        settings: data,
      );
    },
    VerifyChangePhoneScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerifyChangePhoneScreen(),
        settings: data,
      );
    },
    ProviderBranchesScreen: (data) {
      final args = data.getArgs<ProviderBranchesScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProviderBranchesScreen(args.offerId),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// OfferDetatilsScreen arguments holder class
class OfferDetatilsScreenArguments {
  final String offerId;
  OfferDetatilsScreenArguments({@required this.offerId});
}

/// ProviderBranchesScreen arguments holder class
class ProviderBranchesScreenArguments {
  final String offerId;
  ProviderBranchesScreenArguments({@required this.offerId});
}
