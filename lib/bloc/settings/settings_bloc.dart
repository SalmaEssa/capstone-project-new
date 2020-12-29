import 'package:auth_provider/AuthProvider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:axon/PODO/City.dart';
import 'package:axon/PODO/User.dart';
import 'package:axon/bloc/bloc.dart';
import 'package:axon/bloc/settings/settings_event.dart';
import 'package:axon/bloc/settings/settings_state.dart';
import 'package:axon/main_router.gr.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/services/CityRegionService.dart';
import 'package:axon/services/auth.dart';
import 'package:axon/services/language.dart';
import 'package:axon/services/profile.dart';
import 'package:fly_networking/Auth/AppException.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:axon/PODO/Customer.dart';

class SettingsBloc extends BLoC<SettingsEvent> {
  final PublishSubject<SettingsState> settingsStateSubject = PublishSubject();
  final Fly _fly = GetIt.instance<Fly>();
  final ProfileService _profileService = GetIt.instance<ProfileService>();
  final LanguageService _languageService = GetIt.instance<LanguageService>();
  final AuthService _authService = GetIt.instance<AuthService>();
  final AuthProvider _authProvider = GetIt.instance<AuthProvider>();
  final CityRegionService _cityRegionService =
      GetIt.instance<CityRegionService>();
  Customer custumer;

  List<City> cities;
  String selectedLangCode;
  String _language = LanguageService.deviceLanguage;
  bool hasUser;
  String locale = "";

  @override
  Future<void> dispatch(SettingsEvent event) async {
    if (event is InitialLanguageRequested) {
      await _getInitialLanguage();
    }

    if (event is LanguageSelected) {
      this.selectedLangCode = event.langCode;
      _languageService.setLanguage(event.langCode);

      settingsStateSubject.add(LanguageIs(event.langCode));
    }
    if (event is LanguageChanged) {
      await changeLanguage(event.lang);
    }

    if (event is LogoutTapped) {
      await _logout();
    }

    if (event is ChangePhoneRequested) {
      await _authPhone(event);
    }
    if (event is VerifyChangePhoneScreenLaunched) {
      _getPhone();
    }
    if (event is VerifyChangedPhoneNumber) {
      _changePhoneNumber(event);
    }
    if (event is ResendCodePressed) {
      _resendSMS(event).catchError(
          (onError) => settingsStateSubject.sink.add(WrongPhoneCode()));
    }
    if (event is ProfileRequested) {
      getProfileData();
    }
    if (event is EditProfileData) {
      await editProfile(event.fullName, event.email, event.dateOfBirth,
          event.city, event.region);
    }
  }

  Future<void> editProfile(String name, String email, DateTime birthday,
      String city, String regon) async {
    await _profileService.editCustomerProfile(
        name, email, birthday, city, regon);
  }

  Future<void> getProfileData() async {
    custumer = await _profileService.getCustomer();
    if (custumer != null) settingsStateSubject.add(CustomerProfileIs(custumer));
  }

  Future<void> changeLanguage(String langCode) async {
    await _languageService.saveSelectedLanguage(langCode, "");
    AppStrings.setCurrentLocal(langCode);
    settingsStateSubject.add(ChangedLanguage());
  }

  Future<void> _getInitialLanguage() async {
    _language = await _languageService.getLanguage();
    settingsStateSubject.add(LanguageIsSelected(_language));
  }

  Future<void> _logout() async {
    await _authService.logout();
    settingsStateSubject.add(UserLoggedOut());
  }

  void _getPhone() async {
    settingsStateSubject.sink
        .add(NewPhoneNumberIs(_authService.getPhoneNumber()));
  }

  Future<void> _authPhone(ChangePhoneRequested event) async {
    _authService.sendSMS(event.phoneNumber);
    ExtendedNavigator.root.push(Routes.verifyChangePhoneScreen);
  }

  void _changePhoneNumber(VerifyChangedPhoneNumber event) async {
    await _verifyPhone(event).catchError((onError) {
      if (onError is AppException)
        settingsStateSubject.sink.add(WrongPhoneNumber(onError.beautifulMsg));
      else
        settingsStateSubject.sink.add(WrongPhoneCode());
    });
  }

  Future<void> _verifyPhone(VerifyChangedPhoneNumber event) async {
    await _authService.authMethodLogout(); // Logout Firebase User

    await _authService.verifyPhoneNumber(event.smsCode, true);

    _fly.addHeaders({
      CodeStrings.authorization:
          '${CodeStrings.bearer} ${(_authProvider.user as User).jwtToken}'
    });

    ExtendedNavigator.root.popUntil((route) {
      if (route.settings.name == Routes.screenWrapper) return true;
      return false;
    });

    settingsStateSubject.sink.add(ChangePhoneNumberSuccess());
  }

  Future<void> _resendSMS(ResendCodePressed event) async {
    if (event.phoneNumber == null) return;
    _authService.sendSMS(event.phoneNumber);
  }

  dispose() {
    settingsStateSubject.close();
  }
}
