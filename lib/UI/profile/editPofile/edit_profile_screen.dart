import 'dart:async';
import 'package:axon/UI/home/settings_screen.dart';
import 'package:axon/bloc/settings/settings_bloc.dart';
import 'package:axon/bloc/settings/settings_state.dart';
import 'package:axon/bloc/settings/settings_event.dart';

import 'package:flutter/material.dart';
import 'package:axon/PODO/City.dart';
import 'package:axon/PODO/Region.dart';
import 'package:axon/UI/profile/compeletProfile/input_question_widget.dart';
import 'package:axon/bloc/auth/auth_bloc.dart';
import 'package:axon/shared_widgets/select_question_widget.dart';
import 'package:axon/bloc/profile/profile_bloc.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/shared_widgets/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:axon/bloc/profile/profile_state.dart';
import 'package:axon/bloc/profile/profile_event.dart';
import 'package:axon/resources/strings.dart';
import 'package:get_it/get_it.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';
import 'package:axon/main_router.gr.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final SettingsBloc _settingsBloc = GetIt.instance<SettingsBloc>();
  StreamSubscription _settingsSub;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _selectedCity;
  String _selectedRegion; // Option 2
  String _inputBirthday;
  City city;
  Region region;
  List<Region> regions = [];
  double topcitypadding = 0;
  double topregionpadding = 0;
  bool change;
  DateTime _selectedDate;
  String preselectedValue;
  ProfileBloc _profileBloc = GetIt.instance<ProfileBloc>();
  StreamSubscription subject;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  List<City> cities = [];
  final AuthBloc _authBloc = GetIt.instance<AuthBloc>();
  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  Future<void> _submitForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        loading = true;
      });
      await _settingsBloc.dispatch(EditProfileData(
          city: _selectedCity,
          email: _emailController.text.trim(),
          region: _selectedRegion,
          fullName: _fullNameController.text.trim(),
          dateOfBirth: _selectedDate));
      ExtendedNavigator.root
          .pushAndRemoveUntil(Routes.settingsScreen, (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    subject = _profileBloc.profileSubject.listen((state) {
      if (state is CitiesAre) {
        setState(() {
          if (state.cities != null) {
            cities = state.cities;
            // getFirstRegions();
          }
        });
      }
    });

    _settingsSub = _settingsBloc.settingsStateSubject.listen((recievedState) {
      if (recievedState is CustomerProfileIs) {
        setState(() {
          _fullNameController.text = recievedState.customer.name;
          _emailController.text = recievedState.customer.email;
          DateFormat format = DateFormat("yyyy-MM-dd");
          print("birthday isssssssss ");
          print(recievedState.customer.birthdate);
          _selectedDate = format.parse(recievedState.customer.birthdate);

          _selectedCity = recievedState.customer.city.name;
          _selectedRegion = recievedState.customer.region.name;
          getRegions();
          print(_selectedDate);
          print(_selectedCity);
          print(_selectedRegion);
        });
      }
    });
    _profileBloc.dispatch(CompeletProfileLunch());

    _settingsBloc.dispatch(ProfileRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: InkWell(
            onTap: _submitForm,
            child: Text(
              AppStrings.saveCap,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: AppColors.blueAccent,
        elevation: 0,
        toolbarHeight: 121,
        leading: FlatButton(
          onPressed: () {
            ExtendedNavigator.root.pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.lightGrayBackground,
          ),
        ),
      ),
      body: loading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: AppColors.blueAccent,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: AppColors.white),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // _buildNameQuestonWidget(AppStrings.fullName),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLableQuestionWidget(AppStrings.fullName),
                              Container(
                                margin: EdgeInsetsDirectional.only(top: 16),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    if (value.length <= 2) {
                                      return 'tha name should be more than 2 characters ';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    _fullNameController.text = value.trim();
                                  },
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.lightTextColor,
                                  ),
                                  controller: _fullNameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.lightGrayBackground,
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.lightGrayStroke)),
                                    hintText: AppStrings.fullName,
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.lightTextColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          // _buildEmailQuestonWidget(AppStrings.emailAddress,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLableQuestionWidget(
                                  AppStrings.emailAddress),
                              Container(
                                margin: EdgeInsetsDirectional.only(top: 16),
                                child: TextFormField(
                                  validator: (value) {
                                    if (!emailRegex.hasMatch(value)) {
                                      return 'Please enter valid email';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    _emailController.text = value.trim();
                                  },
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.lightTextColor,
                                  ),
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.lightGrayBackground,
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.lightGrayStroke)),
                                    hintText: AppStrings.exampleEmail,
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.lightTextColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          _buildQuestonBirthdayWidget(AppStrings.birthday,
                              AppStrings.taptoopencalendar),
                          SizedBox(
                            height: 25,
                          ),
                          _buildCityAreaQuesWiget(),
                          SizedBox(
                            height: 25,
                          ),
                          _buildAreaQuesWiget()
                        ],
                      ),
                    ),
                  )),
            ),
    );
  }

  Widget _buildLableQuestionWidget(String question) {
    return Text(
      question,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: AppColors.lightTextColor,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildQuestonBirthdayWidget(
    String queston,
    String inputLable,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLableQuestionWidget(queston),
        _buildBirthdayWidget(
          inputLable,
        ),
      ],
    );
  }

  Widget _buildBirthdayWidget(String inputLable) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: AppColors.lightGrayBackground),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        color: AppColors.lightGrayBackground,
        onPressed: _presentDataPicker,
        child: Container(
          height: 68,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            _selectedDate == null
                ? 'inputLable'
                : '${DateFormat("dd MMMM,yyyy").format(_selectedDate)}',
            style: TextStyle(
              color: AppColors.lightTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _presentDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        // ready = true;
      });
    });
  }

  getRegions() {
    setState(() {
      print(_selectedRegion);
      city = cities.firstWhere((element) => element.name == _selectedCity);
      regions = city.regions;
      print(_selectedRegion);
    });
  }

  setRegion() {
    setState(() {
      region = regions.firstWhere((element) => element.name == _selectedRegion);
      // print(region.name);
      // print(region.id);

      // ready = true;
    });
  }

  Widget _buildCityAreaQuesWiget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLableQuestionWidget(AppStrings.city),
        (cities.length != 0 && cities != null)
            ? SelectQuestionWidget(
                items: cities,
                onPressed: (newValue) {
                  setState(() {
                    topcitypadding = 0;
                    _selectedCity = newValue;
                    regions = null;
                    getRegions();
                    topregionpadding = 12;
                    // ready = false;
                    _selectedRegion = preselectedValue;
                  });
                },
                label: AppStrings.taptoselectcity,
                padding: topcitypadding,
                selectedItem: _selectedCity,
              )
            : Container(),
      ],
    );
  }

  Widget _buildAreaQuesWiget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLableQuestionWidget(AppStrings.area),
        (regions.length != 0 && regions != null)
            ? SelectQuestionWidget(
                items: regions,
                onPressed: (newValue) {
                  setState(() {
                    topregionpadding = 0;
                    _selectedRegion = newValue;
                  });

                  setRegion();
                },
                label: AppStrings.taptoselectarea,
                padding: topregionpadding,
                selectedItem: _selectedRegion,
                key: Key(city.id),
              )
            : Container(),
      ],
    );
  }
}
