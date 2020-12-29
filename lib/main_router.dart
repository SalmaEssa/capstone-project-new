import 'package:auto_route/auto_route_annotations.dart';
import 'package:axon/UI/home/offer/offer_details_screen.dart';
import 'package:axon/UI/home/offer/provider_branches_screen.dart';
import 'package:axon/UI/SearchAndFilter/filter_screen.dart';
import 'package:axon/UI/SearchAndFilter/main_search_screen.dart';

import 'package:axon/UI/home/settings_screen.dart';
import 'package:axon/UI/profile/compeletProfile/complete_profile_screen.dart';
import 'package:axon/UI/home/screen_wrapper.dart';

import 'package:axon/UI/profile/editPofile/edit_profile_screen.dart';

import 'package:axon/UI/Auth/auth_screen.dart';
import 'package:axon/UI/Auth/verification_screen.dart';
import 'package:axon/UI/profile/change_phone_screen.dart';
import 'package:axon/UI/profile/verify_change_phone_screen.dart';
import 'package:axon/UI/splash_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: AuthScreen),
    MaterialRoute(page: VerificationScreen),
    MaterialRoute(page: ScreenWrapper),
    MaterialRoute(page: SettingsScreen),
    MaterialRoute(page: EditProfileScreen),
    MaterialRoute(page: CompleteProfileScreen),
    MaterialRoute(page: MainSearchScreen),
    MaterialRoute(page: FilterScreen),
    MaterialRoute(page: OfferDetatilsScreen),
    MaterialRoute(page: ChangePhoneScreen),
    MaterialRoute(page: VerifyChangePhoneScreen),
    MaterialRoute(page: ProviderBranchesScreen),
  ],
)
class $MainRouter {}
