import 'package:auth_provider/AuthProvider.dart';
import 'package:axon/PODO/Membership.dart';
import 'package:axon/PODO/User.dart';
import 'package:axon/bloc/auth/auth_bloc.dart';
import 'package:axon/bloc/bloc.dart';
import 'package:axon/bloc/discover/bloc.dart';
import 'package:axon/bloc/offer_details/bloc.dart';
import 'package:axon/bloc/profile/bloc.dart';
import 'package:axon/bloc/search/bloc.dart';
import 'package:axon/bloc/root/root_event.dart';
import 'package:axon/bloc/settings/settings_bloc.dart';
import 'package:axon/resources/links.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/services/CityRegionService.dart';
import 'package:axon/services/MemberShip.dart';
import 'package:axon/services/Offer.dart';
import 'package:axon/services/profile.dart';

import 'package:axon/services/language.dart';
import 'package:axon/services/Provider.dart';
import 'package:axon/services/auth.dart';
import 'package:fly_networking/fly.dart';
import 'package:axon/provider/shared_preferences_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootBloc extends BLoC<RootEvent> {
  SharedPreferencesProvider _sharedPreferencesProvider;

  @override
  void dispatch(RootEvent event) async {
    if (event is ModulesInitialized) {
      _initData();
      _initSharedPreferences();
    }

    if (event is ModulesRestarted) {
      _restartGetIt();
      _initSharedPreferences();
    }

    if (event is PackageInfoRequested) {}
  }

  void _initData() {
    GetIt.instance.reset();
    String gqLink = AppLinks.protocol + AppLinks.apiBaseLink + "/graphql";

    GetIt.instance
        .registerLazySingleton<ProfileService>(() => ProfileService());
    GetIt.instance.registerSingleton<Fly<dynamic>>(Fly<dynamic>(gqLink));
    GetIt.instance
        .registerLazySingleton<AuthProvider>(() => AuthProvider(User()));
    GetIt.instance.registerLazySingleton<AuthService>(() => AuthService());
    GetIt.instance
        .registerLazySingleton<LanguageService>(() => LanguageService());
    GetIt.instance.registerSingleton<SharedPreferencesProvider>(
        SharedPreferencesProvider());
    GetIt.instance.registerSingleton<MemberShipService>(MemberShipService());

    GetIt.instance.registerLazySingleton<AuthBloc>(() => AuthBloc());
    GetIt.instance.registerLazySingleton<SettingsBloc>(() => SettingsBloc());

    GetIt.instance
        .registerLazySingleton<CityRegionService>(() => CityRegionService());

    GetIt.instance.registerLazySingleton<ProfileBloc>(() => ProfileBloc());

    GetIt.instance.registerSingleton<OfferService>(OfferService());
    GetIt.instance.registerSingleton<ProviderService>(ProviderService());
    GetIt.instance.registerSingleton<DiscoverBloc>(DiscoverBloc());
    GetIt.instance.registerSingleton<OfferDetailsBloc>(OfferDetailsBloc());
    GetIt.instance.registerSingleton<SearchBloc>(SearchBloc());
  }

  void _restartGetIt() {
    GetIt.instance.resetLazySingleton<AuthService>(
        instance: GetIt.instance<AuthService>());
    GetIt.instance.resetLazySingleton<LanguageService>(
        instance: GetIt.instance<LanguageService>());
    GetIt.instance
        .resetLazySingleton<AuthBloc>(instance: GetIt.instance<AuthBloc>());
    GetIt.instance.resetLazySingleton<SettingsBloc>(
        instance: GetIt.instance<SettingsBloc>());
    GetIt.instance.resetLazySingleton<CityRegionService>(
        instance: GetIt.instance<CityRegionService>());

    GetIt.instance
        .resetLazySingleton<AuthProvider>(instance: AuthProvider(User()));
    GetIt.instance.registerSingleton<SharedPreferencesProvider>(
        SharedPreferencesProvider());
    GetIt.instance.registerSingleton<MemberShipService>(MemberShipService());

    GetIt.instance.registerSingleton<OfferService>(OfferService());

    GetIt.instance.registerSingleton<ProviderService>(ProviderService());
    GetIt.instance.registerSingleton<DiscoverBloc>(DiscoverBloc());
    GetIt.instance.registerSingleton<OfferDetailsBloc>(OfferDetailsBloc());
    GetIt.instance.registerSingleton<SearchBloc>(SearchBloc());

    GetIt.instance.resetLazySingleton<ProfileBloc>(
        instance: GetIt.instance<ProfileBloc>());
  }

  Future<void> _getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    print("App name is $appName");
    print("Package name is $packageName");
    print("Version is $version");
    print("Build number is $buildNumber");

    String cachedBuild = await _sharedPreferencesProvider
        .getBuildNumber(CodeStrings.buildNumberKey);
    if (cachedBuild == null ||
        int.parse(buildNumber) > int.parse(cachedBuild)) {
      _clearCache();
      _sharedPreferencesProvider.setBuildNumber(buildNumber);
    }
  }

  void _clearCache() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  void _initSharedPreferences() {
    _sharedPreferencesProvider = GetIt.instance<SharedPreferencesProvider>();
  }
}
