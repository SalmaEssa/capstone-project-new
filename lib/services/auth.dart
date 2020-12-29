import 'package:auth_provider/AuthProvider.dart';
import 'package:auth_provider/AuthProviderUser.dart';
import 'package:auth_provider/UserInterface.dart';
import 'package:auth_provider/auth_methods/OTPAuthMethod.dart';
import 'package:axon/PODO/User.dart';
import 'package:axon/resources/links.dart';
import 'package:axon/resources/strings.dart';
import 'package:fly_networking/GraphQB/graph_qb.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';

class AuthService {
  final Fly _fly = GetIt.instance<Fly<dynamic>>();
  final AuthProvider _authProvider = GetIt.instance<AuthProvider>();
  String idToken;

  OTPAuthMethod otpMethod = OTPAuthMethod(
    apiLink: AppLinks.protocol + AppLinks.apiBaseLink + "/graphql",
    phoneNumber: "",
  );

  void sendSMS(String phoneNumber) {
    otpMethod.phoneNumber = phoneNumber;
    otpMethod.sendSMS();
  }

  String getPhoneNumber() => otpMethod.phoneNumber;

  Future<void> verifyPhoneNumber(String smsCode, bool isChangePhone) async {
    idToken = await otpMethod.getIdToken(smsCode);

    print('SERVICE SMS CODE ===> $smsCode');
    print('ID TOKEN ===> $idToken');
    await _authProvider.loginWith(
      callType: isChangePhone ? _changePhoneCallType : _authCallType,
      method: otpMethod,
    );
  }

  Future<AuthUser> _authCallType(AuthUser authproviderUser) async {
    print("Auth call  typeeeeeee staaaaaaaaaaaaaaaaaaaaart");
    Node node = Node(name: "login", args: {
      "type": "_PHONE",
      "role": "_CUSTOMER",
      "phone": otpMethod.phoneNumber.replaceAll("+2", ""),
      "token": idToken
    }, cols: [
      "id",
      "phone",
      "role",
      "type",
      "jwtToken",
      "expire"
    ]);
    var returnedUser =
        await _fly.mutation([node], parsers: {"login": User.empty()});
    print("backfrom jason");
    return returnedUser["login"];
    // return null;
  }

  Future<AuthUser> _changePhoneCallType(AuthUser authproviderUser) async {
    Node _otpAuthNode = Node(
      name: CodeStrings.changePhoneNodeName,
      args: {
        CodeStrings.typeArgument: CodeStrings.phoneEnum,
        CodeStrings.phoneArgument:
            otpMethod.phoneNumber.substring(3), // Neglecting "+20"
        CodeStrings.tokenArgument: idToken,
        CodeStrings.roleArgument: CodeStrings.customerRole,
      },
      cols: [
        CodeStrings.jwtTokenColumn,
        CodeStrings.roleColumn,
        CodeStrings.expireColumn,
        CodeStrings.idColumn,
      ],
    );

    Map result = await _fly.mutation([_otpAuthNode],
        parsers: {_otpAuthNode.name: AuthProviderUser()});
    AuthProviderUser user = result[_otpAuthNode.name];

    return User()
      ..id = user.id
      ..jwtToken = user.token
      ..role = user.role
      ..expire = user.expire;
  }

  Future<void> authMethodLogout() async {
    await otpMethod.logout();
  }

  Future<bool> hasUser() async {
    return await _authProvider.hasUser();
  }

  Future<void> logout() async {
    await GetIt.instance<AuthProvider>().logout();

    Node _logoutNode = Node(name: CodeStrings.logoutNodeName);

    await _fly.query([_logoutNode]);
  }
}
