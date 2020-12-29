import 'package:axon/PODO/City.dart';
import 'package:axon/PODO/Customer.dart';

abstract class SettingsState {}

class LanguageIsSelected extends SettingsState {
  final String language;

  LanguageIsSelected(this.language);
}

class LanguageIs extends SettingsState {
  String language;
  LanguageIs(this.language);
}

class ChangedLanguage extends SettingsState {
  ChangedLanguage();
}

class CitiesAreEdit extends SettingsState {
  List<City> cities;

  CitiesAreEdit(this.cities);
}

class CustomerProfileIs extends SettingsState {
  final Customer customer;

  CustomerProfileIs(this.customer);
}

class ShowDialog extends SettingsState {}

class UserLoggedOut extends SettingsState {}

class NewPhoneNumberIs extends SettingsState {
  String newPhoneNumber;
  NewPhoneNumberIs(this.newPhoneNumber);
}

class WrongPhoneCode extends SettingsState {}

class WrongPhoneNumber extends SettingsState {
  String error;
  WrongPhoneNumber(this.error);
}

class ChangePhoneNumberSuccess extends SettingsState {}
