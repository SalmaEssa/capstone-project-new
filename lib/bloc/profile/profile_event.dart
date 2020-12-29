abstract class ProfileEvent {}

class CompeletProfileLunch extends ProfileEvent {}

class SelectedCityIs extends ProfileEvent {
  String id;
  SelectedCityIs(this.id);
}

class CompleteProfileData extends ProfileEvent {
  String fullName;
  String email;
  DateTime dateOfBirth;
  String city;
  String region;
  CompleteProfileData(
      {this.fullName, this.email, this.dateOfBirth, this.city, this.region});
}
