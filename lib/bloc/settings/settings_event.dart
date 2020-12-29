abstract class SettingsEvent {}

class InitialLanguageRequested extends SettingsEvent {}

class LanguageSelected extends SettingsEvent {
  String langCode;
  LanguageSelected(this.langCode);
}

class EditProfileLunched extends SettingsEvent {}

class LanguageChanged extends SettingsEvent {
  String lang;
  LanguageChanged(this.lang);
}

class ProfileRequested extends SettingsEvent {}

class UpdatedProfileRequested extends SettingsEvent {}

class LogoutTapped extends SettingsEvent {}

class EditProfileData extends SettingsEvent {
  String fullName;
  String email;
  DateTime dateOfBirth;
  String city;
  String region;
  EditProfileData(
      {this.fullName, this.email, this.dateOfBirth, this.city, this.region});
}

class EditProfileDone extends SettingsEvent {}

class ChangePhoneRequested extends SettingsEvent {
  String phoneNumber;
  ChangePhoneRequested(this.phoneNumber);
}

class VerifyChangePhoneScreenLaunched extends SettingsEvent {}

class VerifyChangedPhoneNumber extends SettingsEvent {
  String smsCode;
  VerifyChangedPhoneNumber(this.smsCode);
}

class ResendCodePressed extends SettingsEvent {
  String phoneNumber;
  ResendCodePressed(this.phoneNumber);
}
