import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:axon/bloc/settings/bloc.dart';
import 'package:axon/main_router.gr.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/resources/themes.dart';
import 'package:axon/shared_widgets/Language/LanguageField.dart';
import 'package:axon/shared_widgets/custom_network_image.dart';
import 'package:axon/shared_widgets/dialog_box.dart';
import 'package:axon/shared_widgets/sliver_screen/sliver_screen.dart';
import 'package:axon/shared_widgets/snack_bar_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:axon/bloc/settings/settings_bloc.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with RouteAware {
  String _username;
  String _phoneNumber;
  String _profilePictureUrl;
  final SettingsBloc _settingsBloc = GetIt.instance<SettingsBloc>();
  StreamSubscription _settingsSub;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String language = AppStrings.currentCode == CodeStrings.englishCode
      ? AppStrings.english
      : AppStrings.arabic;

  @override
  void initState() {
    _settingsSub = _settingsBloc.settingsStateSubject.listen((recievedState) {
      if (recievedState is LanguageIsSelected) {
        setState(() {
          language = recievedState.language == CodeStrings.englishCode
              ? AppStrings.english
              : AppStrings.arabic;
        });
      }
      if (recievedState is ChangePhoneNumberSuccess) {
        _showSnackBar();
      }
      if (recievedState is CustomerProfileIs) {
        setState(() {
          _username = recievedState.customer.name;
          _phoneNumber = recievedState.customer.phone;
          _profilePictureUrl = recievedState.customer.photo;
        });
      }
    });

    _settingsBloc.dispatch(ProfileRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverScreen(
      editWidget: _buildEditWidget(),
      subtitleWidget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProfilePicture(),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              _username ?? "",
              style: AppThemes.textTheme.headline3
                  .copyWith(color: AppColors.white),
            ),
          ),
          Text(
            '( ${CodeStrings.phoneKey} $_phoneNumber )' ?? "",
            style:
                AppThemes.textTheme.bodyText1.copyWith(color: AppColors.white),
          ),
        ],
      ),
      builder: _buildBody,
    );
  }

  Widget _buildEditWidget() {
    return GestureDetector(
      onTap: () {
        ExtendedNavigator.root.push(
          Routes.editProfileScreen,
        );
      },
      child: Align(
        alignment: AlignmentDirectional.topEnd,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset(CodeStrings.editIcon),
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.white,
          ),
          width: 160,
          height: 160,
        ),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.lightGrayStroke),
          width: 150,
          height: 150,
          child: CustomNetworkImage(
            url: _profilePictureUrl ?? "",
            errorWidget: _buildImagePlaceHolder(),
            placeHolder: _buildImagePlaceHolder(),
            imageBuilder: (context, image) => Image(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePlaceHolder() {
    return Image.asset(CodeStrings.person, scale: 0.7);
  }

  Widget _buildBody(BuildContext builderContext) {
    return Column(
      children: [
        _buildRowElement(
          () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) {
                  return LanguageField();
                });
          },
          Text(
            AppStrings.lang,
            style: AppThemes.textTheme.subtitle1
                .copyWith(color: AppColors.darkBluePrimary),
          ),
          Text(
            language,
            style: AppThemes.textTheme.subtitle1
                .copyWith(color: AppColors.greenAccent),
          ),
        ),
        _buildRowElement(
          () => ExtendedNavigator.root.push(Routes.changePhoneScreen),
          Text(
            AppStrings.changePhone,
            style: AppThemes.textTheme.subtitle1
                .copyWith(color: AppColors.darkBluePrimary),
          ),
        ),
        _buildRowElement(
          () {},
          Text(
            AppStrings.redeemedOffers,
            style: AppThemes.textTheme.subtitle1
                .copyWith(color: AppColors.darkBluePrimary),
          ),
        ),
        _buildRowElement(
          () {},
          Text(
            AppStrings.aboutAxon,
            style: AppThemes.textTheme.subtitle1
                .copyWith(color: AppColors.darkBluePrimary),
          ),
        ),
        _buildRowElement(
          _logout,
          Text(
            AppStrings.logout,
            style: AppThemes.textTheme.subtitle1
                .copyWith(color: AppColors.redError),
          ),
        ),
      ],
    );
  }

  void _logout() async {
    bool dialogResult = await showDialog(
      context: context,
      builder: (_) => DialogBox(
        title: AppStrings.logoutQuestion,
        submitText: AppStrings.logout,
        alertColors: true,
      ),
    );

    if (dialogResult ?? false) {
      _settingsBloc.dispatch(LogoutTapped());
    }
  }

  Widget _buildSuccessWidget() {
    return new SnackBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100))),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: new Container(
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
                      AppStrings.profileupdatedsuccessfully,
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
              child: IconButton(
                  onPressed: () {
                    Scaffold.of(context)..removeCurrentSnackBar();
                  },
                  icon: Icon(Icons.close, color: AppColors.greenSuccess)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowElement(Function onTap, Text leading, [Text trailing]) {
    return ListTile(
      // wont follow the design UI, because the widget has a default padding
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      onTap: onTap,
      leading: leading,
      trailing: trailing ?? SizedBox(),
    );
  }

  void _showSnackBar() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: SnackBarContent(
          context: context,
          title: AppStrings.success,
          content: AppStrings.changePhoneSuccess,
          isSuccess: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _settingsSub.cancel();
    super.dispose();
  }
}
