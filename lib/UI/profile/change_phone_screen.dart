import 'dart:async';

import 'package:axon/bloc/settings/bloc.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/resources/themes.dart';
import 'package:axon/shared_widgets/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class ChangePhoneScreen extends StatefulWidget {
  @override
  _ChangePhoneScreenState createState() => _ChangePhoneScreenState();
}

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  final SettingsBloc _settingsBloc = GetIt.instance<SettingsBloc>();

  StreamSubscription _settingsSub;

  TextEditingController controller = TextEditingController();

  bool _ready = false;
  bool _enable = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPhoneSection(),
            _buildButtomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneSection() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text(
            AppStrings.byContinuingyou,
            style: TextStyle(
              color: AppColors.greenAccent,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          AppStrings.newPhoneNumber,
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
              child: TextField(
                enabled: _enable || _hasError,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: controller,
                onChanged: (String value) {
                  (value?.trim()?.length >= 10)
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonWidget(
            ready: _ready,
            change: _hasError,
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

    if (phoneNumber[0] == "0") phoneNumber = phoneNumber.substring(1);

    setState(() => _enable = false);
    _settingsBloc
        .dispatch(ChangePhoneRequested(CodeStrings.phoneKey + phoneNumber));
  }

  @override
  void dispose() {
    _settingsSub.cancel();
    super.dispose();
  }
}
