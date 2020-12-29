import 'dart:async';

import 'package:axon/shared_widgets/restartWidget.dart';
import 'package:flutter/material.dart';
import 'package:axon/bloc/settings/bloc.dart';
import 'package:axon/bloc/settings/settings_bloc.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/resources/dimens.dart';
import 'package:get_it/get_it.dart';

class LanguageField extends StatefulWidget {
  @override
  _LanguageFieldState createState() => _LanguageFieldState();
}

class _LanguageFieldState extends State<LanguageField> {
  String selectedLang = AppStrings.currentCode == CodeStrings.arabicCode
      ? CodeStrings.arabicCode
      : CodeStrings.englishCode;
  SettingsBloc _settingsBloc = GetIt.instance<SettingsBloc>();
  StreamSubscription sub;

  @override
  void initState() {
        print( AppStrings.currentCode);
    sub = _settingsBloc.settingsStateSubject.listen((state) {
      if (state is ChangedLanguage) {
        RestartWidget.restartApp(context);
        print("herrrrre");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: AppDimens.screenPadding,
                end: AppDimens.screenPadding,
                top: AppDimens.screenPadding,
              ),
              child: Text(
                AppStrings.changelanguage,
                style: TextStyle(
                    color: AppColors.darkBluePrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: <Widget>[
                  ListTile(
                  title: Text(
                    AppStrings.arabic,
                    
                  ),
                  leading: new Radio(
                    activeColor: AppColors.yellow,
                    value: CodeStrings.arabicCode,
                    groupValue: selectedLang,
                    onChanged: (String value) {
                      setState(() {
                        selectedLang = value;
                        print(selectedLang);
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    AppStrings.english,
                  
                  ),
                  leading: new Radio(
                    activeColor: AppColors.yellow,
                    value: CodeStrings.englishCode,
                    groupValue: selectedLang,
                    onChanged: (String value) {
                      setState(() {
                        selectedLang = value;
                        print(selectedLang);
                      });
                    },
                  ),
                ),
              
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppStrings.cancel,
                  style: TextStyle(
                    color: AppColors.greenAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),),
              ),
              FlatButton(
                onPressed: () {
                  if (AppStrings.currentCode != selectedLang) {
                          _settingsBloc
                              .dispatch(LanguageChanged(selectedLang));
                        }
                        if(AppStrings.currentCode == selectedLang){
                         Navigator.pop(context);
                        }

                
                },
                child: Text(AppStrings.confirm,
                style: TextStyle(
                    color: AppColors.redError,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),),
              )
            ])
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
