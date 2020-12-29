import 'package:axon/bloc/auth/bloc.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthBloc _authBloc = GetIt.instance<AuthBloc>();

  @override
  void initState() {
    super.initState();
    _authBloc.dispatch(CheckForUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueAccent,
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Image.asset(CodeStrings.smallLogo),
          ),
          Image.asset(CodeStrings.logoName, scale: 2.2),
        ],
      )),
    );
  }
}
