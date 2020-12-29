import 'dart:async';

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

class CompleteProfileScreen extends StatefulWidget {
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  ProfileBloc _profileBloc = GetIt.instance<ProfileBloc>();

  List<City> cities = [];
  final AuthBloc _authBloc = GetIt.instance<AuthBloc>();

  bool ready;
  int selectedIndex = 0;
  PageController _pageController;
  StreamSubscription subject;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _selectedCity;
  String _selectedRegion; // Option 2
  City city;
  Region region;
  List<Region> regions = [];
  double topcitypadding = 12;
  double topregionpadding = 12;
  bool change;
  DateTime _selectedDate;
  String preselectedValue;
  @override
  void initState() {
    ready = false;
    change = false;
    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );

    subject = _profileBloc.profileSubject.listen((state) {
      if (state is CitiesAre) {
        setState(() {
          if (state.cities != null) {
            cities = state.cities;
          }
        });
      }
    });

    _profileBloc.dispatch(CompeletProfileLunch());
    super.initState();
  }

  void bottonTapped(int index) {
    setState(() {
      selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void backButtonTapped(int index) {
    setState(() {
      selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 50), curve: Curves.ease);
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
      ready = true;
    });
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
        ready = true;
      });
    });
  }

  @override
  void dispose() {
    subject.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.blueAccent,
            elevation: 0,
            toolbarHeight: 121,
            leading: (selectedIndex == 0)
                ? Container()
                : FlatButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex -= 1;
                        backButtonTapped(selectedIndex);
                        ready = true;
                      });
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.lightGrayBackground,
                    ),
                  ),
            title: Container(
              height: 45,
              child: Image.asset(CodeStrings.logoName),
            ),
          ),
          body: SafeArea(
              child: Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: PageView(
                      physics: new NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children: [
                        _buildNameQuestonWidget(
                          AppStrings.whatisyourFullName,
                        ),
                        _buildEmailQuestonWidget(
                          AppStrings.andwhatisyourEmailAddress,
                        ),
                        _buildQuestonBirthdayWidget(
                            AppStrings.whenisyourBirthday,
                            AppStrings.taptoopencalendar),
                        _buildCityAreaQuesWiget(),
                      ],
                    )),
                    Container(
                      child: Column(
                        children: [
                          _buildProgressIndecatorWidget(),
                          _buildButtomSection(),
                        ],
                      ),
                    ),
                  ],
                )),
          ))),
    );
  }

  Widget _buildNameQuestonWidget(
    String queston,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLableQuestionWidget(queston),
        InputQuestionWidget(
          onPressed: (String value) {
            if (value?.length > 1) {
              setState(() {
                ready = true;
              });
            } else {
              setState(() {
                ready = false;
              });
            }
          },
          controller: _fullNameController,
          label: AppStrings.fullName,
        ),
      ],
    );
  }

  Widget _buildEmailQuestonWidget(String queston) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLableQuestionWidget(queston),
        InputQuestionWidget(
          onPressed: (String value) {
            if (validateEmail()) {
              setState(() {
                print(_emailController.text);
                ready = true;
              });
            } else {
              setState(() {
                print(_emailController.text);
                ready = false;
              });
            }
          },
          controller: _emailController,
          label: AppStrings.exampleEmail,
        ),
      ],
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

  Widget _buildCityAreaQuesWiget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLableQuestionWidget(AppStrings.wheredoyoulive),
        (cities.length != 0 && cities != null)
            ? SelectQuestionWidget(
                items: cities,
                onPressed: (newValue) {
                  setState(() {
                    topcitypadding = 0;
                    _selectedCity = newValue;
                    regions = null;
                    topregionpadding = 12;
                    ready = false;
                    _selectedRegion = preselectedValue;

                    getRegions();
                  });
                },
                label: AppStrings.taptoselectcity,
                padding: topcitypadding,
                selectedItem: _selectedCity,
              )
            : Container(),
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
                ? inputLable
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

  Widget _buildLableQuestionWidget(String question) {
    return Text(
      question,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: AppColors.lightTextColor,
        fontSize: 25,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildProgressIndecatorWidget() {
    return LinearPercentIndicator(
      animation: false,
      lineHeight: 12.0,
      animationDuration: 1,
      percent: (selectedIndex + 1) / 4,
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: AppColors.greenAccent,
      backgroundColor: AppColors.lightGrayStroke,
    );
  }

  Widget _buildButtomSection() {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Container(
                width: 233,
                child: Text(
                  "${selectedIndex + 1}" "/4",
                  style: TextStyle(
                    color: AppColors.darkBluePrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )),
          ),
          ButtonWidget(
            ready: ready,
            change: change,
            onPressed: () {
              if (ready) {
                setState(() {
                  if (selectedIndex != 3) {
                    selectedIndex += 1;
                    bottonTapped(selectedIndex);
                  }
                  if (!change) {
                    ready = false;
                  }
                });
              }
              if (_selectedRegion.length > 1 && selectedIndex == 3) {
                setState(() {
                  change = true;
                });
                print("1");
                print("finiiiiiiiiiish of   itttt ");
                print(_selectedCity);
                print(_selectedRegion);
                _profileBloc.dispatch(CompleteProfileData(
                    city: _selectedCity,
                    region: _selectedRegion,
                    email: _emailController.text.trim(),
                    fullName: _fullNameController.text.trim(),
                    dateOfBirth: _selectedDate));
              }
            },
          ),
        ],
      ),
    );
  }

  bool validateEmail() {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text)) {
      return true;
    } else {
      return false;
    }
  }
}
