import 'package:auth_provider/AuthProvider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:axon/PODO/Customer.dart';
import 'package:axon/PODO/User.dart';
import 'package:axon/bloc/auth/auth_event.dart';
import 'package:axon/bloc/auth/auth_state.dart';
import 'package:axon/bloc/settings/settings_bloc.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/services/profile.dart';
import 'package:axon/main_router.gr.dart';
import 'package:axon/services/auth.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:axon/bloc/bloc.dart';
import 'package:axon/PODO/Customer.dart';

class AuthBloc extends BLoC<AuthEvent> {
  final PublishSubject authSubject = PublishSubject<AuthState>();

  final AuthProvider _authProvider = GetIt.instance<AuthProvider>();
  final AuthService _authService = GetIt.instance<AuthService>();
  final Fly _fly = GetIt.instance<Fly>();
  final ProfileService _profileService = GetIt.instance<ProfileService>();
  bool _isCompletedProfile;

  Customer customer;
  @override
  void dispatch(AuthEvent event) async {
    if (event is AuthPhone) {
      await _authPhone(event).catchError((e) => print(e));
    }
    if (event is VerificationScreenLaunched) {
      _getPhone();
    }
    if (event is VerifyPhoneNumber) {
      _verifyPhone(event)
          .catchError((onError) => authSubject.sink.add(WrongPhoneCode()));
    }
    if (event is ResendCodePressed) {
      _resendSMS(event)
          .catchError((onError) => authSubject.sink.add(WrongPhoneCode()));
    }
    if (event is CheckForUser) {
      _checkForUser();
    }
  }

  Future<void> _authPhone(AuthPhone event) async {
    _authService.sendSMS(event.phoneNumber);
    ExtendedNavigator.root
        .pushAndRemoveUntil(Routes.verificationScreen, (route) => false);
  }

  Future<void> _verifyPhone(VerifyPhoneNumber event) async {
    try {
      print("holaaa1 ");
      await _authService.authMethodLogout();
      print("holaaa  2 ");

      await _authService.verifyPhoneNumber(event.smsCode, false);
      print("holaaa  3 ");

      _addTokenHeader();
      print("holaaa  4 ");

      //ExtendedNavigator.root .pushAndRemoveUntil(Routes.completeProfileScreen, (_) => false);
      customer = await _profileService.getCustomer();
      print("after getCustomer caaameee");
      print(customer.profileStatus);
      if (customer.profileStatus == "INCOMPLETE")
        _isCompletedProfile = false;
      else
        _isCompletedProfile = true;
      _navigateUser(true, _isCompletedProfile);
    } catch (error) {
      print("the cus usis ");
      print(customer);
      print("error");
    }
  }

  Future<void> _resendSMS(ResendCodePressed event) async {
    if (event.phoneNumber == null) return;
    _authService.sendSMS(event.phoneNumber);
  }

  Future<void> _checkForUser() async {
    print(
        "chhhhhhhchchchchchchhchchchchchchchchchchchhchchchchchchchchchchchchchhchcchch");
    final bool _hasUser = await _authProvider.hasUser();

    if (!_hasUser) {
      _navigateUser(false, false);
      return;
    }
    _addTokenHeader();
    print("yees he haas useer");

    customer = await _profileService.getCustomer();
    print("thecus is ");
    print(customer.phone);
    if (customer.profileStatus == "INCOMPLETE")
      _isCompletedProfile = false;
    else
      _isCompletedProfile = true;

    _navigateUser(_hasUser, _isCompletedProfile);
  }

  void _getPhone() async {
    authSubject.sink.add(UserPhoneIs(_authService.getPhoneNumber()));
  }

  void _addTokenHeader() {
    _fly.addHeaders({
      CodeStrings.authorization:
          '${CodeStrings.bearer} ${(_authProvider.user as User).jwtToken}'
    });
  }

  /////////////////////changed sec route;

  void _navigateUser(bool _hasUser, bool _isCompletedProfile) {
    // If you have a user
    if (_hasUser) {
      if (_isCompletedProfile) // If user's customer is completed
        ExtendedNavigator.root
            .pushAndRemoveUntil(Routes.screenWrapper, (route) => false);
      else // If user's customer is incomplete
        ExtendedNavigator.root
            .pushAndRemoveUntil(Routes.completeProfileScreen, (route) => false);
    } else // If you have no user
      ExtendedNavigator.root
          .pushAndRemoveUntil(Routes.authScreen, (route) => false);
  }

  void dispose() {
    authSubject.close();
  }
}
