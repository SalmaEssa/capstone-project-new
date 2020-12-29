import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:axon/bloc/auth/bloc.dart';
import 'package:axon/main_router.gr.dart';
import 'package:axon/resources/themes.dart';
import 'package:axon/shared_widgets/ButtonWidget.dart';
import 'package:axon/shared_widgets/sliver_screen/sliver_screen.dart';
import 'package:flutter/material.dart';
import 'package:axon/bloc/auth/auth_bloc.dart';
import 'package:axon/resources/strings.dart';
import 'package:get_it/get_it.dart';
import 'package:axon/resources/colors.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final AuthBloc _authBloc = GetIt.instance<AuthBloc>();
  StreamSubscription _streamSubscription;
  bool ready;
  bool _enable;
  bool hasError = false;
  String phoneNumber;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  Timer timer;
  final int smsCooldown = 60;
  int _remainingSeconds = 0;
  bool enableLoading = false;
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    ready = false;
    _enable = true;
    enableLoading = false;
    _streamSubscription = _authBloc.authSubject.listen((receivedState) {
      if (receivedState is UserPhoneIs) {
        setState(() => phoneNumber = receivedState.phoneNumber);
      }
      if (receivedState is WrongPhoneCode) {
        setState(() {
          hasError = true;
          enableLoading = false;
          ready = false;
        });
        controllers.forEach((TextEditingController element) => element.clear());
      }
    });
    _authBloc.dispatch(VerificationScreenLaunched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverScreen(
      shrinkOpacityFactor: 1.6,
      titleWidget: Image.asset(
        CodeStrings.smallLogo,
        scale: 1.2,
        alignment: Alignment.center,
      ),
      subtitleWidget: Padding(
        padding: const EdgeInsets.only(top: 350, left: 150, right: 150),
        child: Image.asset(
          CodeStrings.logoName,
          scale: 1.5,
          alignment: Alignment.bottomCenter,
        ),
      ),
      builder: (BuildContext scaffoldContext) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitleSection(scaffoldContext),
              _buildButtomSection(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitleSection(BuildContext scaffoldContext) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(),
        _buildInputBoxesRow(),
        hasError ? _buildErrorMessage() : Container(),
        _buildResendCode(scaffoldContext),
      ],
    ));
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: AppStrings.otpUserHint,
            style: AppThemes.textTheme.subtitle1,
          ),
          TextSpan(
            text: phoneNumber,
            style: AppThemes.textTheme.subtitle1
                .copyWith(color: AppColors.greenAccent),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBoxesRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: key,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: [
              Spacer(),
              _buildTextField(controllers[0], focusNodes[0]),
              Spacer(),
              _buildTextField(controllers[1], focusNodes[1]),
              Spacer(),
              _buildTextField(controllers[2], focusNodes[2]),
              Spacer(),
              _buildTextField(controllers[3], focusNodes[3]),
              Spacer(),
              _buildTextField(controllers[4], focusNodes[4]),
              Spacer(),
              _buildTextField(controllers[5], focusNodes[5]),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        AppStrings.invalidCode,
        style:
            AppThemes.textTheme.bodyText1.copyWith(color: AppColors.redError),
      ),
    );
  }

  Widget _buildResendCode(BuildContext scaffoldContext) {
    final TextStyle style = _isResendCooldown
        ? AppThemes.textTheme.bodyText1
            .copyWith(color: AppColors.lightTextColor.withOpacity(1))
        : AppThemes.textTheme.subtitle1
            .copyWith(color: AppColors.purplePrimary);

    return _isResendCooldown
        ? Text(
            _remainingSeconds > 9
                ? "${AppStrings.resendCodeIn}" + "00:$_remainingSeconds"
                : "${AppStrings.resendCodeIn}" + "00:0$_remainingSeconds",
            style: style,
          )
        : GestureDetector(
            onTap: () {
              _authBloc.dispatch(ResendCodePressed(phoneNumber));
              Scaffold.of(scaffoldContext).showSnackBar(_buildSuccessWidget());
              startTimer();
            },
            child: Text(
              AppStrings.resendCode,
              style: style,
            ),
          );
  }

  Widget _buildSuccessWidget() {
    return SnackBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100))),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        color: AppColors.greenLight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.greenSuccess,
              width: 4,
              height: 70,
            ),
            Padding(
              // padding is for the container not it's content
              padding: const EdgeInsets.all(15),
              child: Container(
                width: 30.0,
                height: 30.0,
                child: Icon(Icons.check),
                decoration: new BoxDecoration(
                  color: AppColors.greenSuccess,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.success,
                    style: TextStyle(
                      color: AppColors.darkBluePrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      AppStrings.verificationSent,
                      style: TextStyle(
                        color: AppColors.darkBluePrimary,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Icon(Icons.close, color: AppColors.greenSuccess),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (timer.tick >= smsCooldown) timer.cancel();
      setState(() {
        _remainingSeconds = smsCooldown - timer.tick;
      });
    });
  }

  Widget _buildTextField(
      TextEditingController controller, FocusNode focusNode) {
    return Container(
      height: 100,
      width: 40,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.length == 1) FocusScope.of(context).nextFocus();
          if (controllers.every((element) => element.text.isNotEmpty))
            setState(() => ready = true);
        },
        maxLength: 1,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildButtomSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              ExtendedNavigator.root
                  .pushAndRemoveUntil(Routes.authScreen, (route) => false);
            },
            child: Text(
              AppStrings.editMyPhone,
              style: AppThemes.textTheme.subtitle1
                  .copyWith(color: AppColors.purplePrimary),
            ),
          ),
        ),
        ButtonWidget(
          ////////////////////////////////////////////////heree
          ready: ready,
          change: enableLoading,
          onPressed: () {
            setState(() {
              hasError = false;
              enableLoading = true;
            });

            String smsCode = controllers.fold<String>(
                "", (previousValue, element) => previousValue + element.text);
            print('SMS CODE ===> $smsCode');
            _authBloc.dispatch(VerifyPhoneNumber(smsCode));
            // ExtendedNavigator.of(context).pushAndRemoveUntil(Routes.completeProfileScreen, (_) => false);
          },
        ),
      ],
    );
  }

  bool get _isResendCooldown {
    return timer?.isActive ?? false;
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
