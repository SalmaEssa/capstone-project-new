import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:axon/bloc/settings/bloc.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/resources/themes.dart';
import 'package:axon/shared_widgets/ButtonWidget.dart';
import 'package:axon/shared_widgets/snack_bar_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class VerifyChangePhoneScreen extends StatefulWidget {
  @override
  _VerifyChangePhoneScreenState createState() =>
      _VerifyChangePhoneScreenState();
}

class _VerifyChangePhoneScreenState extends State<VerifyChangePhoneScreen> {
  final SettingsBloc _settingsBloc = GetIt.instance<SettingsBloc>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  StreamSubscription _streamSubscription;
  bool ready;
  bool _enable;
  bool hasError = false;
  String phoneNumber;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  Timer timer;
  final int smsCooldown = 60;

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

    _streamSubscription =
        _settingsBloc.settingsStateSubject.listen((receivedState) {
      if (receivedState is NewPhoneNumberIs) {
        setState(() => phoneNumber = receivedState.newPhoneNumber);
      }
      if (receivedState is WrongPhoneCode) {
        setState(() => hasError = true);
        controllers.forEach((TextEditingController element) => element.clear());
      }
      if (receivedState is WrongPhoneNumber) {
        _showSnackBar(AppStrings.error, receivedState.error, false);
        controllers.forEach((TextEditingController element) => element.clear());
      }
    });

    _settingsBloc.dispatch(VerifyChangePhoneScreenLaunched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.blueAccent,
      appBar: AppBar(
        // leading: _buildBackButton(),
        title: Text(
          AppStrings.verifyPhoneNumber,
          style: AppThemes.englishAppTheme.textTheme.headline3
              .copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitleSection(),
            Spacer(),
            _buildButtomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(),
        _buildInputBoxesRow(),
        hasError ? _buildErrorMessage() : Container(),
        _buildResendCode(),
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

  Widget _buildResendCode() {
    final TextStyle style = _isResendCooldown
        ? AppThemes.textTheme.bodyText1
            .copyWith(color: AppColors.lightTextColor.withOpacity(1))
        : AppThemes.textTheme.subtitle1
            .copyWith(color: AppColors.purplePrimary);

    return _isResendCooldown
        ? Text(
            "${AppStrings.resendCodeIn} ${smsCooldown - timer.tick}",
            style: style,
          )
        : GestureDetector(
            onTap: () {
              _settingsBloc.dispatch(ResendCodePressed(phoneNumber));
              _showSnackBar(
                  AppStrings.success, AppStrings.verificationSent, true);
              _startTimer();
            },
            child: Text(
              AppStrings.resendCode,
              style: style,
            ),
          );
  }

  void _showSnackBar(String title, String content, bool isSuccess) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: SnackBarContent(
          scaffoldKey: _scaffoldKey,
          title: title,
          content: content,
          isSuccess: isSuccess,
        ),
      ),
    );
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (timer.tick >= smsCooldown) timer.cancel();
      setState(() {});
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
            onTap: () => ExtendedNavigator.root.pop(),
            child: Text(
              AppStrings.editMyPhone,
              style: AppThemes.textTheme.subtitle1
                  .copyWith(color: AppColors.purplePrimary),
            ),
          ),
        ),
        ButtonWidget(
          ready: ready,
          onPressed: () {
            setState(() => hasError = false);

            String smsCode = controllers.fold<String>(
                "", (previousValue, element) => previousValue + element.text);
            _settingsBloc.dispatch(VerifyChangedPhoneNumber(smsCode));
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
    timer.cancel();
    _streamSubscription.cancel();
    super.dispose();
  }
}
