import 'dart:async';
import 'package:auth_provider/AuthProvider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:axon/PODO/User.dart';
import 'package:axon/bloc/auth/auth_bloc.dart';
import 'package:axon/bloc/auth/auth_state.dart';
import 'package:axon/bloc/root/root_bloc.dart';
import 'package:axon/bloc/root/root_event.dart';
import 'package:axon/bloc/settings/settings_bloc.dart';
import 'package:axon/bloc/settings/settings_event.dart';
import 'package:axon/bloc/settings/settings_state.dart';
import 'package:axon/main_router.gr.dart';
import 'package:axon/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:axon/resources/themes.dart';
import 'package:get_it/get_it.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _locale = CodeStrings.englishCode;
  RootBloc _rootBloc;
  SettingsBloc _settingsBloc;
  StreamSubscription _settingsSubscription;

  @override
  void initState() {
    GetIt.instance.registerSingleton<RootBloc>(RootBloc());
    _rootBloc = GetIt.instance<RootBloc>();
    _rootBloc.dispatch(ModulesInitialized());
    _listenForLangChange();
    _listenForLogout();
    _rootBloc.dispatch(PackageInfoRequested());
    super.initState();
  }

  ///TODO: Needs Refactoring
  void _listenForLangChange() {
    _settingsBloc = GetIt.instance<SettingsBloc>();
    _settingsBloc.dispatch(InitialLanguageRequested());
    _settingsSubscription =
        _settingsBloc.settingsStateSubject.listen((SettingsState state) async {
      if (state is LanguageIsSelected) {
        AppStrings.setCurrentLocal(state.language);
        setState(() {
          _locale = state.language;
        });
      }
    });
  }

  ///TODO: Will be removed after [_listenForLangChange] refactoring
  void _listenForLogout() {
    _settingsBloc = GetIt.instance<SettingsBloc>();
    _settingsSubscription = _settingsBloc.settingsStateSubject.listen((state) {
      if (state is UserLoggedOut) {
        _listenForLangChange();
        _rootBloc.dispatch(ModulesRestarted());
        ExtendedNavigator.root
            .pushAndRemoveUntil(Routes.authScreen, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _locale == CodeStrings.arabicCode
            ? AppThemes.arabicAppTheme
            : AppThemes.englishAppTheme,
        builder: ExtendedNavigator.builder<MainRouter>(
          router: MainRouter(),
          builder: (context, extendedNav) => Directionality(
            textDirection: _locale == CodeStrings.arabicCode
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: extendedNav,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _settingsSubscription.cancel();
    super.dispose();
  }
}
