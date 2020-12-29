abstract class AuthState {}

class UserPhoneIs extends AuthState {
  final String phoneNumber;

  UserPhoneIs(this.phoneNumber);
}

class WrongPhoneCode extends AuthState {}
