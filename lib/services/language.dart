import 'package:axon/provider/shared_preferences_provider.dart';
import 'package:axon/resources/strings.dart';
import 'package:fly_networking/GraphQB/graph_qb.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter_device_locale/flutter_device_locale.dart';

class LanguageService {
  final Fly _fly = GetIt.instance<Fly>();
  String selectedLangCode;

  LanguageService() {
    selectedLangCode = deviceLanguage;
  }
  void setLanguage(String lang) {
    selectedLangCode = lang;
  }

  Future<String> getLanguage() async {
    SharedPreferencesProvider sharedPrefs = SharedPreferencesProvider();
    String selectedLanguage = await sharedPrefs.getLanguage();

    if (selectedLanguage == null) selectedLanguage = await _getDeviceLanguage();

    _fly.addHeaders({CodeStrings.languageHeader: selectedLanguage});
    AppStrings.setCurrentLocal(selectedLanguage);
    return selectedLanguage;
  }

  Future<String> _getDeviceLanguage() async {
    Locale mobileLocale = await DeviceLocale.getCurrentLocale();
      print(mobileLocale.languageCode);
    if(mobileLocale.languageCode != CodeStrings.englishCode  ){

     _fly.addHeaders({CodeStrings.languageHeader: CodeStrings.arabicCode});
    return CodeStrings.arabicCode ;
  }
    _fly.addHeaders({CodeStrings.languageHeader: mobileLocale.languageCode});
    return mobileLocale.languageCode;
  }

  Future<void> saveSelectedLanguage(String lang, String customerId) async {
    SharedPreferencesProvider sharedPrefs = SharedPreferencesProvider();
    selectedLangCode = lang;
    sharedPrefs.setLanguage(lang);

    selectedLangCode = lang ?? selectedLangCode;

    //Header for non-logged requests
    // _fly.addHeaders({CodeStrings.languageHeader: lang});
    //
    // if (customerId == null) return;
    //
    // //Request For logged Users
    // Node changeLanguageNode = Node(
    //   name: CodeStrings.updateCustomerNodeName,
    //   args: {
    //     CodeStrings.idColumn: customerId,
    //     CodeStrings.localeColumn: selectedLangCode,
    //   },
    //   cols: [CodeStrings.localeColumn],
    // );
    //
    // await _fly.mutation([changeLanguageNode]);
    editLanguage();
  }

  Future<void> editLanguage() async {
    SharedPreferencesProvider sharedPrefs = SharedPreferencesProvider();
    sharedPrefs.setLanguage(selectedLangCode);
  }

  static String get deviceLanguage {
    String lang = ui.window.locale.languageCode;

    if (lang != CodeStrings.englishCode && lang != CodeStrings.arabicCode) {
      return CodeStrings.englishCode;
    }

    return lang;
  }
}
