abstract class AuthEvent {}

class AuthPhone extends AuthEvent {
  String phoneNumber;
  AuthPhone(this.phoneNumber);
}

class VerificationScreenLaunched extends AuthEvent {}

class VerifyPhoneNumber extends AuthEvent {
  String smsCode;
  VerifyPhoneNumber(this.smsCode);
}

class ResendCodePressed extends AuthEvent {
  String phoneNumber;
  ResendCodePressed(this.phoneNumber);
}

class CheckForUser extends AuthEvent {}
