import 'package:axon/PODO/City.dart';

abstract class ProfileState {}

class CitiesAre extends ProfileState {
  List<City> cities;

  CitiesAre(this.cities);
}
