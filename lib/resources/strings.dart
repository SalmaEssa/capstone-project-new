import 'package:rxdart/rxdart.dart';

class AppStrings {
  static PublishSubject<String> langChangedSubject = PublishSubject();
  static String currentCode = CodeStrings.englishCode;

  static Map<String, Map<String, String>> _translationsMap = {
    CodeStrings.englishCode: {
      'helloWorldText': 'Hello World',
      'changelanguage': 'Change Language',
      'language': 'Language',
      'arabic': 'اللغة العربية',
      'english': 'English',
      'cancel': 'CANCEL',
      'confirm': 'CONFIRM',
      'whatisyourFullName': 'What is your Full Name?',
      'fullName': 'Full Name',
      'andwhatisyourEmailAddress': 'And what is your Email Address?',
      'exampleEmail': 'example@domain.com',
      'whenisyourBirthday': 'When is your Birthday?',
      'taptoopencalendar': 'Tap to open calendar',
      'wheredoyoulive': 'Where do you live?',
      'taptoselectcity': 'Tap to select city',
      'taptoselectarea': 'Tap to select area',
      'lang': 'Language',
      'changePhone': 'Change Phone Number',
      'redeemedOffers': 'Redeemed Offers',
      'contactUs': 'Contact Us',
      'aboutAxon': 'About Axon',
      'logout': 'Logout',
      'wrongCredentialsErrorMessage': 'Please double-check and try again',
      'byContinuingyou':
          'By Continuing you will receive a one time password for verification',
      'phoneNumber': 'Phone Number',
      'phoneLable': 'XXXXXXXXXX',
      'phoneKey': '+20',
      'phoneError': 'Please provide a valid phone number',
      'otpUserHint':
          'Enter the 6 digit verification code that was sent to you at: ',
      'resendCode': 'Resend Code',
      'resendCodeIn': 'Resend Code in ',
      'editMyPhone': 'Edit my phone number',
      'invalidCode': 'The verification code you’ve entered is incorrect',
      'success': 'Success',
      'error': 'Error',
      'verificationSent': 'Verification code resent',
      'whatareyoulookingfor': 'What are you looking for',
      'wecouldnotfindanyoffersmatchingyoursearch':
          'We couldn’t find any offers matching your search',
      'clear': 'CLEAR',
      'membershipType': 'Membership Type',
      'logoutQuestion': 'Are you sure you want to Logout?',
      'saveCap': 'SAVE',
      'emailAddress': 'Email Address',
      'birthday': 'Birthday',
      'city': 'City',
      'area': 'Area',
      'savingChanges': 'Saving Changes',
      'cannotSaveChanges': 'Cannot Save Changes',
      'pleasefillmissingfields': 'Please fill missing fields',
      'profileupdatedsuccessfully': 'Profile updated successfully',
      'searchHint': 'What are you looking for',
      'hotDeal': 'Hot Deal',
      'getOffer': 'GET OFFER',
      'egp': 'EGP',
      'noMembership': 'No Membership Required',
      'ourCategories': 'Our Categories',
      'verifyPhoneNumber': 'Verify phone number',
      'changePhoneSuccess': 'Phone number changed successfully',
      'newPhoneNumber': 'New Phone Number',
      'membershipRequired': 'Membership Required',
      'membershipRequiredHint':
          'You are required to have one of these memberships to get this offer',
      'availableBranches': 'Available Branches',
      'validUntil': 'Valid until',
      'redeemOffer': 'REDEEM OFFER',
      'noMemberships': 'No Membership',
      'sHOWOFFERS': 'SHOW OFFERS',
      'all': 'all',
      'allCapital': 'All',
      'bROWSECATEGORIES': 'BROWSE CATEGORIES',
    },
    CodeStrings.arabicCode: {
      'helloWorldText': 'مرحبا',
      'wrongCredentialsErrorMessage': 'يرجى التحقق والمحاولة مرة أخرى',
      'changelanguage': 'اختر اللغة',
      'language': 'اللغة',
      'arabic': 'اللغة العربية',
      'english': 'English',
      'cancel': 'إلغاء',
      'confirm': 'تأكيد',
      'whatisyourFullName': 'اسمك ايه؟',
      'fullName': ' الإسم الثنائي',
      'whenisyourBirthday': 'تاريخ ميلادك ايه؟',
      //TODO:: Change this text when you get it from the story
      'taptoopencalendar': 'Tap to open calendar',
      'wheredoyoulive': 'ساكن فين؟',
      'taptoselectcity': 'دوس لإختيار المحافظة',
      'taptoselectarea': 'دوس لإختيار المنطقة',
      'lang': 'اللغة',
      'changePhone': 'تغيير رقم التليفون',
      'redeemedOffers': 'العروض المحصلة',
      'contactUs': 'تواصل معنا',
      //TODO:: Change this text when you get it from the story
      'aboutAxon': 'About Axon',
      'logout': 'تسجيل الخروج',
      'byContinuingyou':
          'عند المتابعة هتجيلك رسالة على تليفونك فيها رمز التأكيد',
      'phoneNumber': 'رقم التليفون',
      'phoneLable': 'XXXXXXXXXX',
      'phoneKey': '+20',
      'phoneError': 'اكتب رقم التليفون الصحيح',
      'otpUserHint': 'يرجي كتابة كود التأكيد المرسل إلى: ',
      'resendCode': 'إعادة إرسال الكود',
      'resendCodeIn': 'إعادة إرسال الكود في خلال:',
      'editMyPhone': 'تغيير رقم التليفون',
      'invalidCode': 'الكود اللي كتبته غير صحيح',
      'success': 'عملية ناجحه',
      'error': 'خطأ',
      'verificationSent': 'تم إعادة إرسال كود التأكيد',
      'whatareyoulookingfor': 'بتدور على ايه؟',
      'wecouldnotfindanyoffersmatchingyoursearch': ' ملقيناش عروض مناسبة لبحثك',
      'clear': 'مسح الكل',
      'membershipType': 'العضوية',

      'logoutQuestion': 'هل انت متأكد من رغبتك في تسجيل الخروج؟',
      'saveCap': 'حفظ',
      'emailAddress': 'البريد الالكتروني',
      'birthday': 'تاريخ ميلادك',
      'city': 'المحافظة',
      'area': 'المنطقة',
      'savingChanges': 'جاري حفظ البيانات',
      'cannotSaveChanges': ' لا يمكن حفظ التغييرات',
      'pleasefillmissingfields': 'ادخل البيانات المطلوبة',
      'profileupdatedsuccessfully': ' تم تعديل الحساب',
      'searchHint': 'بتدور على ايه؟',
      'hotDeal': 'عرض خاص',
      'getOffer': 'احصل على العرض',
      'egp': 'جنيه',
      'noMembership': 'متاح لغير الأعضاء',
      'ourCategories': 'الأقسام',
      'verifyPhoneNumber': 'تأكيد رقم التليفون',
      'changePhoneSuccess': 'تم تغيير رقم التليفون',
      'newPhoneNumber': 'رقم التليفون الجديد',
      'membershipRequired': 'للأعضاء فقط',
      'membershipRequiredHint':
          'اشتري واحدة من العضويات المطلوبة علشان تقدر تحصل على العرض ده',
      'availableBranches': 'الفروع المتاحة',
      'validUntil': 'متاح حتى',
      'redeemOffer': 'احصل على العرض',
      'noMemberships': 'متاح لغير الأعضاء',
      'sHOWOFFERS': 'العروض',
      'all': 'all',
      'allCapital': 'الكل',
      //TODO:: Change this text when you get it from the story
      'bROWSECATEGORIES': 'BROWSE CATEGORIES',
    },
  };

  static String get bROWSECATEGORIES =>
      _translationsMap[currentCode]["bROWSECATEGORIES"];

  static String get all => _translationsMap[currentCode]["all"];
  static String get allCapital => _translationsMap[currentCode]["allCapital"];
  static String get sHOWOFFERS => _translationsMap[currentCode]["sHOWOFFERS"];

  static String get noMemberships =>
      _translationsMap[currentCode]["noMemberships"];
  static String get membershipType =>
      _translationsMap[currentCode]["membershipType"];

  static String get clear => _translationsMap[currentCode]["clear"];

  static String get wecouldnotfindanyoffersmatchingyoursearch =>
      _translationsMap[currentCode]
          ["wecouldnotfindanyoffersmatchingyoursearch"];

  static String get whatareyoulookingfor =>
      _translationsMap[currentCode]["whatareyoulookingfor"];

  static String get profileupdatedsuccessfully =>
      _translationsMap[currentCode]["profileupdatedsuccessfully"];

  static String get changelanguage =>
      _translationsMap[currentCode]["changelanguage"];

  static String get arabic => _translationsMap[currentCode]["arabic"];

  static String get cancel => _translationsMap[currentCode]["cancel"];

  static String get confirm => _translationsMap[currentCode]["confirm"];

  static String get english => _translationsMap[currentCode]["english"];

  static String get helloWorldText =>
      _translationsMap[currentCode]["helloWorldText"];
  static String get language => _translationsMap[currentCode]["language"];
  static String get wrongCredentialsErrorMessage =>
      _translationsMap[currentCode]["wrongCredentialsErrorMessage"];

  static String get whatisyourFullName =>
      _translationsMap[currentCode]["whatisyourFullName"];
  static String get fullName => _translationsMap[currentCode]["fullName"];
  static String get andwhatisyourEmailAddress =>
      _translationsMap[currentCode]["andwhatisyourEmailAddress"];
  static String get exampleEmail =>
      _translationsMap[currentCode]["exampleEmail"];
  static String get whenisyourBirthday =>
      _translationsMap[currentCode]["whenisyourBirthday"];
  static String get taptoopencalendar =>
      _translationsMap[currentCode]["taptoopencalendar"];
  static String get wheredoyoulive =>
      _translationsMap[currentCode]["wheredoyoulive"];
  static String get taptoselectcity =>
      _translationsMap[currentCode]["taptoselectcity"];

  static String get taptoselectarea =>
      _translationsMap[currentCode]["taptoselectarea"];

  static String get lang => _translationsMap[currentCode]["lang"];
  static String get changePhone => _translationsMap[currentCode]["changePhone"];
  static String get redeemedOffers =>
      _translationsMap[currentCode]["redeemedOffers"];
  static String get contactUs => _translationsMap[currentCode]["contactUs"];
  static String get aboutAxon => _translationsMap[currentCode]["aboutAxon"];
  static String get logout => _translationsMap[currentCode]["logout"];
  static String get byContinuingyou =>
      _translationsMap[currentCode]["byContinuingyou"];

  static String get phoneNumber => _translationsMap[currentCode]["phoneNumber"];
  static String get phoneLable => _translationsMap[currentCode]["phoneLable"];

  static String get phoneKey => _translationsMap[currentCode]["phoneKey"];

  static String get phoneError => _translationsMap[currentCode]["phoneError"];

  static String get otpUserHint => _translationsMap[currentCode]["otpUserHint"];
  static String get invalidCode => _translationsMap[currentCode]["invalidCode"];
  static String get resendCode => _translationsMap[currentCode]["resendCode"];
  static String get resendCodeIn =>
      _translationsMap[currentCode]["resendCodeIn"];
  static String get editMyPhone => _translationsMap[currentCode]["editMyPhone"];
  static String get success => _translationsMap[currentCode]["success"];
  static String get error => _translationsMap[currentCode]["error"];
  static String get verificationSent =>
      _translationsMap[currentCode]["verificationSent"];
  static String get logoutQuestion =>
      _translationsMap[currentCode]["logoutQuestion"];

  static String get saveCap => _translationsMap[currentCode]["saveCap"];
  static String get pleasefillmissingfields =>
      _translationsMap[currentCode]["pleasefillmissingfields"];

  static String get emailAddress =>
      _translationsMap[currentCode]["emailAddress"];

  static String get birthday => _translationsMap[currentCode]["birthday"];

  static String get city => _translationsMap[currentCode]["city"];

  static String get area => _translationsMap[currentCode]["area"];

  static String get savingChanges =>
      _translationsMap[currentCode]["savingChanges"];

  static String get cannotSaveChanges =>
      _translationsMap[currentCode]["cannotSaveChanges"];
  static String get searchHint => _translationsMap[currentCode]["searchHint"];

  static String get hotDeal => _translationsMap[currentCode]["hotDeal"];
  static String get getOffer => _translationsMap[currentCode]["getOffer"];
  static String get egp => _translationsMap[currentCode]["egp"];
  static String get noMembership =>
      _translationsMap[currentCode]["noMembership"];
  static String get ourCategories =>
      _translationsMap[currentCode]["ourCategories"];
  static String get membershipRequired =>
      _translationsMap[currentCode]["membershipRequired"];
  static String get membershipRequiredHint =>
      _translationsMap[currentCode]["membershipRequiredHint"];
  static String get availableBranches =>
      _translationsMap[currentCode]["availableBranches"];
  static String get validUntil => _translationsMap[currentCode]["validUntil"];
  static String get redeemOffer => _translationsMap[currentCode]["redeemOffer"];

  static String get verifyPhoneNumber =>
      _translationsMap[currentCode]["verifyPhoneNumber"];
  static String get changePhoneSuccess =>
      _translationsMap[currentCode]["changePhoneSuccess"];
  static String get newPhoneNumber =>
      _translationsMap[currentCode]["newPhoneNumber"];

  static void setCurrentLocal(String code) {
    currentCode = code;
    if (code != CodeStrings.englishCode && code != CodeStrings.arabicCode) {
      currentCode = CodeStrings.englishCode;
    }
    langChangedSubject.sink.add(currentCode);
  }

  void dispose() {
    langChangedSubject.close();
  }
}

class CodeStrings {
  /* Language Params */
  static const String englishCode = "en";
  static const String arabicCode = "ar";
  static const String english = "English";
  static const String arabic = "العربية";
  static const String german = "Deutsch";

  /* Assets */
  static const String appLogo = 'assets/app_logo.png';

  static const String sLLogo = 'assets/images/Logo-s-L.png';
  static const String splashLogo = 'assets/images/logo_splash.png';
  static const String smallLogo = 'assets/images/logo_small.png';
  static const String logoName = 'assets/images/logo_name.png';
  static const String homeIcon = 'assets/images/home.png';
  static const String fileIcon = 'assets/images/file-text.png';
  static const String qrIcon = 'assets/images/qr-scan.png';
  static const String bellIcon = 'assets/images/bell.png';
  static const String userIcon = 'assets/images/user.png';
  static const String editIcon = 'assets/images/edit.png';
  static const String person = 'assets/images/person-xl.png';
  static const String vector = 'assets/images/Vector.png';
  static const String searchEmpty = 'assets/images/search_empty.flr';
  static const String search = 'assets/images/search.png';
  static const String subscription = 'assets/images/subscription.png';
  static const String categoty = 'assets/images/categoty.png';
  static const String leftArrow = 'assets/images/arrow-left.png';
  static const String smallRightArrow = 'assets/images/small-arrow-right.png';
  static const String locationIcon = 'assets/images/location.png';

  /* General */
  static const buildNumberKey = "build";
  static const localeKey = "LOCALE";
  static const userKey = "User";
  static const String authorization = "Authorization";
  static const String bearer = "Bearer";
  static const String typeArgument = "type";
  static const String phoneArgument = "phone";
  static const String phoneEnum = "_PHONE";
  static const String roleArgument = "role";
  static const String customerRole = "_CUSTOMER";
  static const String loginNodeName = "login";
  static const String logoutNodeName = "logout";
  static const String myCustomerNodeName = "myCustomer";
  static const String tokenArgument = "token";
  static const String idColumn = "id";
  static const String nameColumn = "name";
  static const String emailColumn = "email";
  static const String roleColumn = "role";
  static const String jwtTokenColumn = "jwtToken";
  static const String expireColumn = "expire";
  static const String resetPasswordNode = "reset_password";
  static const String changePassNodeName = "reAuth_user";
  static const String languageHeader = "Lang";
  static const String localeColumn = "locale";
  static const String photoColumn = "photo";
  static const String city = "city";
  static const String region = "region";
  static const String regions = "regions";
  static const String birthdate = "birthdate";
  static const String phoneColumn = "phone";
  static const String descriptionColumn = "description";
  static const String profileStatusColumn = "status";
  static const String statusCompletedArgument = "_COMPLETED";
  static const String profileStatusCompleted = "COMPLETED";
  static const String profileStatusIncomplete = "INCOMPLETE";
  static const String phoneKey = "+20";
  static const String updateCustomerNodeName = "updateCustomer";
  static const String titleColumn = "title";
  static const String hotDealsNodeName = "hotdeals";
  static const String offersColumn = "offers";
  static const String offerColumn = "offer";
static const String offerNode = "Offer";
  static const String priceColumn = "price";
  static const String axonPriceColumn = "axon_price";
  static const String dueDateColumn = "due_date";
  static const String regionColumn = "region";
  static const String hotdealColumn = "hotdeal";
  static const String offerNodeName = "Offers";
  static const String dynamicSectionsNodeName = "dynamicSections";
  static const String imageLinkColumn = "image_link";
  static const String providerColumn = "provider";
  static const String logoLinkColumn = "logo_link";
  static const String membershipsColumn = "memberships";

  static const String durationColumn = "duration";
  static const String providerTypeColumn = "providerType";
  static const String firstColumn = "first";
  static const String dataColumn = "data";
  static const String whereArgument = "where";
  static const String columnArgument = "column";
  static const String vlaueArgument = "value";
  static const String hotdealEnum = "_HOTDEAL";
  static const String orderByArgument = "orderBy";
  static const String fieldArgument = "field";
  static const String orderArgument = "order";
  static const String createdAtArgument = "_CREATED_AT";
  static const String descArgument = "_DESC";
  static const String providerTypesNodeName = "ProviderTypes";
  static const String logoColumn = "logo";
  static const String changePhoneNodeName = "editPhoneNumber";
  static const String branchesColumn = "branches";
  static const String manulaAdressColumn = "manual_address";
  static const String googleLocationColumn = "google_location_support";
  static const String all = "all";
  static const String offersList = "offersList";
  static const String isPayedColumn = "is_payed";
  static const String payedEnum = "PAYED";
  static const String notPayedEnum = "NOT_PAYED";
}

enum TypeName { NAME }
