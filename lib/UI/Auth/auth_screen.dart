import 'dart:async';

import 'package:axon/bloc/auth/bloc.dart';
import 'package:axon/resources/themes.dart';
import 'package:axon/shared_widgets/ButtonWidget.dart';
import 'package:axon/shared_widgets/sliver_screen/sliver_screen.dart';
import 'package:flutter/material.dart';
import 'package:axon/bloc/auth/auth_bloc.dart';
import 'package:axon/resources/strings.dart';
import 'package:get_it/get_it.dart';
import 'package:axon/resources/colors.dart';
import 'package:flutter/services.dart';
import 'package:axon/main_router.gr.dart';
import 'package:auto_route/auto_route.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthBloc _authBloc = GetIt.instance<AuthBloc>();
  StreamSubscription _streamSubscription;
  TextEditingController controller = TextEditingController();
  bool _ready = false;
  bool _enable = true;
  bool _hasError = false;
  bool enableLoading = false;

  @override
  void initState() {
    _streamSubscription = _authBloc.authSubject.listen((receivedState) {});
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
            children: [
              _buildPhoneSection(),
              _buildButtomSection(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPhoneSection() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.phoneNumber,
          style: TextStyle(
            color: AppColors.lightTextColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildInputBoxRow(),
        _hasError ? _buildErrorMessage() : Container(),
      ],
    ));
  }

  Widget _buildInputBoxRow() {
    return Container(
        margin: EdgeInsetsDirectional.only(top: 17),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: AppColors.lightGrayStroke,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          color: AppColors.lightGrayBackground,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
              child: Text(
                AppStrings.phoneKey,
                style: TextStyle(
                  color: AppColors.darkBluePrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              height: 60,
              child: VerticalDivider(
                color: AppColors.lightGrayStroke,
                thickness: 1.5,
                // color: Colors.black
              ),
            ),
            Container(
              width: 200,
              child: TextFormField(
                enabled: _enable || _hasError,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                controller: controller,
                onChanged: (String value) {
                  (value?.trim().length >= 10)
                      ? setState(() {
                          _ready = true;
                        })
                      : setState(() {
                          _ready = false;
                        });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppStrings.phoneLable,
                  hintStyle: TextStyle(
                    color: AppColors.darkBluePrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildErrorMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        AppStrings.phoneError,
        style:
            AppThemes.textTheme.bodyText1.copyWith(color: AppColors.redError),
      ),
    );
  }

  Widget _buildButtomSection() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Container(
                width: 233,
                child: Text(
                  AppStrings.byContinuingyou,
                  style: TextStyle(
                    color: AppColors.darkBluePrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )),
          ),
          ButtonWidget(
            ready: _ready,
            change: enableLoading,
            onPressed: _authPhone,
          ),
        ],
      ),
    );
  }

  void _authPhone() {
    String phoneNumber = controller.text;

    setState(() {
      _hasError = (phoneNumber.length > 11 || phoneNumber.length < 10);
    });

    if (!_ready || !_enable || _hasError) {
      setState(() => _enable = true);
      return; //enters only if it's ready and enabled
    }
    if (_ready && !_hasError) {
      setState(() => enableLoading = true);
      //enters only if it's ready and enabled
    }

    if (phoneNumber[0] == "0") phoneNumber = phoneNumber.substring(1);

    setState(() => _enable = false);
    _authBloc.dispatch(AuthPhone(CodeStrings.phoneKey + phoneNumber));
    /////////////////////////////////////////////////////////////////////////////////////////hereeeee;

    ExtendedNavigator.root.push(Routes.verificationScreen);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
