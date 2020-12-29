import 'package:auth_provider/AuthProvider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:axon/PODO/City.dart';
import 'package:axon/PODO/Customer.dart';
import 'package:axon/bloc/profile/profile_event.dart';
import 'package:axon/bloc/profile/profile_state.dart';
import 'package:axon/services/CityRegionService.dart';
import 'package:axon/services/auth.dart';
import 'package:axon/services/profile.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:axon/bloc/bloc.dart';

import '../../main_router.gr.dart';

class ProfileBloc extends BLoC<ProfileEvent> {
  final ProfileService _profileService = GetIt.instance<ProfileService>();

  final PublishSubject profileSubject = PublishSubject<ProfileState>();

  final Fly _fly = GetIt.instance<Fly>();
  final AuthService _authService = GetIt.instance<AuthService>();
  final AuthProvider _authProvider = GetIt.instance<AuthProvider>();
  final CityRegionService _cityRegionService =
      GetIt.instance<CityRegionService>();
  Customer custumer;

  List<City> cities;
  bool isSuccess = false;
  @override
  Future<void> dispatch(ProfileEvent event) async {
    if (event is CompeletProfileLunch) {
      await _getCities();

      // _profileService.setCeties(cities);
    }
    if (event is CompleteProfileData) {
      print("2");
      print("before  completeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee  profile end111");

      completeProfile(event.fullName, event.email, event.dateOfBirth,
          event.city, event.region);
    }
  }

  Future<void> completeProfile(String name, String email, DateTime birthday,
      String city, String regon) async {
    print("before  completeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee  profile end");

    custumer = await _profileService.completeCustomerProfile(
        name, email, birthday, city, regon);
    print("afterr  completeeeeeee  profile end");
    print(custumer.email);
    ExtendedNavigator.root
        .pushAndRemoveUntil(Routes.screenWrapper, (route) => false);
  }

  Future<void> _getCities() async {
    cities = await _cityRegionService.getCities();
    print(cities);
    profileSubject.sink.add(CitiesAre(cities));
  }

  void dispose() {
    profileSubject.close();
  }
}
