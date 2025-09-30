import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// 기본 로컬라이제이션 델리게이트와 함께 이 로컬라이제이션 델리게이트 목록.
  ///
  /// 이 델리게이트와 함께 GlobalMaterialLocalizations.delegate,
  /// GlobalCupertinoLocalizations.delegate, 그리고
  /// GlobalWidgetsLocalizations.delegate를 포함하는 로컬라이제이션 델리게이트 목록을 반환합니다.
  ///
  /// MaterialApp에서 이 목록에 추가하여 추가 델리게이트를 추가할 수 있습니다.
  /// 커스텀 델리게이트 목록을 선호하거나 필요한 경우 이 목록을 전혀 사용하지 않아도 됩니다.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// 이 로컬라이제이션 델리게이트가 지원하는 로케일 목록.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('en', 'GB'),
    Locale('fa'),
    Locale('fr'),
    Locale('fr', 'CA')
  ];

  /// 가능한 한 많은 컨텍스트를 제공하세요
  ///
  /// en에서 이 메시지는 다음과 같이 번역됩니다:
  /// **'Hello World!'**
  String get helloWorld;

  /// @greetingMessage에 대한 설명이 제공되지 않았습니다.
  ///
  /// en에서 이 메시지는 다음과 같이 번역됩니다:
  /// **'Hello, {username}! Today is {date}.'**
  String greetingMessage(String username, String date);

  /// @greeting에 대한 설명이 제공되지 않았습니다.
  ///
  /// en에서 이 메시지는 다음과 같이 번역됩니다:
  /// **'{gender, select, male {Hello, Mr. {username}} female {Hello, Ms. {username}} other {Hello, {username}}}'**
  String greeting(String gender, String username);

  /// @emailCount에 대한 설명이 제공되지 않았습니다.
  ///
  /// en에서 이 메시지는 다음과 같이 번역됩니다:
  /// **'{count, plural, =0 {You have no emails} =1 {You have one email} other {You have {count} emails}}'**
  String emailCount(num count);

  /// 잔액 명세서.
  ///
  /// en에서 이 메시지는 다음과 같이 번역됩니다:
  /// **'Your pending cost is {COST}'**
  String costText(num COST);

  /// 간결하게 포맷된 통화 값
  ///
  /// en에서 이 메시지는 다음과 같이 번역됩니다:
  /// **'Total: {value}'**
  String formattedCurrency(double value);

  /// 포맷된 날짜
  ///
  /// en에서 이 메시지는 다음과 같이 번역됩니다:
  /// **'Date: \$date'**
  String formattedDate(DateTime date);
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fa', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {

  // 언어+국가 코드가 지정된 경우 조회 로직
  switch (locale.languageCode) {
    case 'en': {
  switch (locale.countryCode) {
    case 'GB': return SEnGb();
   }
  break;
   }
    case 'fr': {
  switch (locale.countryCode) {
    case 'CA': return SFrCa();
   }
  break;
   }
  }

  // 언어 코드만 지정된 경우 조회 로직
  switch (locale.languageCode) {
    case 'en': return SEn();
    case 'fa': return SFa();
    case 'fr': return SFr();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
