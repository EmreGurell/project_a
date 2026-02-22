import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @error_invalid_credentials.
  ///
  /// In en, this message translates to:
  /// **'User email or password is incorrect!'**
  String get error_invalid_credentials;

  /// No description provided for @error_user_not_found.
  ///
  /// In en, this message translates to:
  /// **'No user found with this email.'**
  String get error_user_not_found;

  /// No description provided for @error_unknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Please try again.'**
  String get error_unknown;

  /// No description provided for @error_validation_error.
  ///
  /// In en, this message translates to:
  /// **'Validation error occurred. Please try again.'**
  String get error_validation_error;

  /// No description provided for @error_unauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized. Please try again.'**
  String get error_unauthorized;

  /// No description provided for @error_token_expired.
  ///
  /// In en, this message translates to:
  /// **'Token expired. Please try again.'**
  String get error_token_expired;

  /// No description provided for @error_invalid_token.
  ///
  /// In en, this message translates to:
  /// **'Invalid token. Please try again.'**
  String get error_invalid_token;

  /// No description provided for @error_not_found.
  ///
  /// In en, this message translates to:
  /// **'Not found. Please try again.'**
  String get error_not_found;

  /// No description provided for @error_user_already_exists.
  ///
  /// In en, this message translates to:
  /// **'User already exists. Please try again.'**
  String get error_user_already_exists;

  /// No description provided for @error_invalid_response.
  ///
  /// In en, this message translates to:
  /// **'Unexpected response received from server. Please try again.'**
  String get error_invalid_response;

  /// No description provided for @error_network_error.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection and try again.'**
  String get error_network_error;

  /// ----- ONBOARDING -----
  ///
  /// In en, this message translates to:
  /// **'Take a photo, let Cimbil calculate'**
  String get onboarding_title_1;

  /// No description provided for @onboarding_desc_1.
  ///
  /// In en, this message translates to:
  /// **'Take a picture of your meal. AI \"Cimbil\" recognizes it and estimates calories.'**
  String get onboarding_desc_1;

  /// No description provided for @onboarding_title_2.
  ///
  /// In en, this message translates to:
  /// **'Track calories, stay in shape!'**
  String get onboarding_title_2;

  /// No description provided for @onboarding_desc_2.
  ///
  /// In en, this message translates to:
  /// **'Save calories for each meal and automatically calculate your daily totals.'**
  String get onboarding_desc_2;

  /// No description provided for @onboarding_title_3.
  ///
  /// In en, this message translates to:
  /// **'Make smarter choices'**
  String get onboarding_title_3;

  /// No description provided for @onboarding_desc_3.
  ///
  /// In en, this message translates to:
  /// **'Stay balanced with daily alerts and summaries. See what to reduce based on your goal.'**
  String get onboarding_desc_3;

  /// No description provided for @onboarding_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_skip;

  /// No description provided for @onboarding_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_next;

  /// No description provided for @onboarding_lets_start.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start'**
  String get onboarding_lets_start;

  /// ----- LOGIN PAGE -----
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcome;

  /// No description provided for @good_to_see_you.
  ///
  /// In en, this message translates to:
  /// **'Good to see you'**
  String get good_to_see_you;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @sign_in_loading.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get sign_in_loading;

  /// No description provided for @continue_with_google.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get continue_with_google;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgot_password;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get create_account;

  /// No description provided for @validation_email_required.
  ///
  /// In en, this message translates to:
  /// **'Email is required.'**
  String get validation_email_required;

  /// No description provided for @validation_email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get validation_email_invalid;

  /// No description provided for @validation_password_required.
  ///
  /// In en, this message translates to:
  /// **'Password is required.'**
  String get validation_password_required;

  /// No description provided for @validation_password_min_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get validation_password_min_length;

  /// No description provided for @validation_first_name_required.
  ///
  /// In en, this message translates to:
  /// **'First name is required.'**
  String get validation_first_name_required;

  /// No description provided for @validation_last_name_required.
  ///
  /// In en, this message translates to:
  /// **'Last name is required.'**
  String get validation_last_name_required;

  /// No description provided for @validation_first_name_invalid.
  ///
  /// In en, this message translates to:
  /// **'First name cannot contain numbers or special characters.'**
  String get validation_first_name_invalid;

  /// No description provided for @validation_last_name_invalid.
  ///
  /// In en, this message translates to:
  /// **'Last name cannot contain numbers or special characters.'**
  String get validation_last_name_invalid;

  /// ----- REGISTER PAGE -----
  ///
  /// In en, this message translates to:
  /// **'Let\'s Get Started'**
  String get register_title;

  /// No description provided for @register_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You can start by creating your account'**
  String get register_subtitle;

  /// No description provided for @register_first_name_label.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get register_first_name_label;

  /// No description provided for @register_last_name_label.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get register_last_name_label;

  /// No description provided for @register_button.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get register_button;

  /// No description provided for @register_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign In'**
  String get register_have_account;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
