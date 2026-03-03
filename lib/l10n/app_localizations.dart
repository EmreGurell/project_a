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

  /// No description provided for @error_timeout.
  ///
  /// In en, this message translates to:
  /// **'Server did not respond. Please try again.'**
  String get error_timeout;

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

  /// ----- FORGOT PASSWORD PAGE -----
  ///
  /// In en, this message translates to:
  /// **'Forgot Your Password?'**
  String get forgot_password_title;

  /// No description provided for @forgot_password_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send you a code'**
  String get forgot_password_subtitle;

  /// No description provided for @forgot_password_send_code.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get forgot_password_send_code;

  /// No description provided for @forgot_password_sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get forgot_password_sending;

  /// No description provided for @back_to_login.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get back_to_login;

  /// ----- VERIFY ACCOUNT PAGE -----
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verify_account_title;

  /// No description provided for @verify_account_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to your email'**
  String get verify_account_subtitle;

  /// No description provided for @verify_account_code_label.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verify_account_code_label;

  /// No description provided for @verify_account_sent_to.
  ///
  /// In en, this message translates to:
  /// **'Code sent to:'**
  String get verify_account_sent_to;

  /// No description provided for @verify_account_button.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify_account_button;

  /// No description provided for @verify_account_loading.
  ///
  /// In en, this message translates to:
  /// **'Verifying...'**
  String get verify_account_loading;

  /// No description provided for @verify_account_resend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get verify_account_resend;

  /// No description provided for @verify_account_resend_loading.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get verify_account_resend_loading;

  /// No description provided for @validation_code_required.
  ///
  /// In en, this message translates to:
  /// **'Verification code is required.'**
  String get validation_code_required;

  /// No description provided for @validation_code_length.
  ///
  /// In en, this message translates to:
  /// **'Code must be 6 digits.'**
  String get validation_code_length;

  /// ----- RESET PASSWORD PAGE -----
  ///
  /// In en, this message translates to:
  /// **'Set New Password'**
  String get reset_password_title;

  /// No description provided for @reset_password_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a strong password'**
  String get reset_password_subtitle;

  /// No description provided for @reset_password_new_label.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get reset_password_new_label;

  /// No description provided for @reset_password_confirm_label.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get reset_password_confirm_label;

  /// No description provided for @reset_password_button.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get reset_password_button;

  /// No description provided for @reset_password_loading.
  ///
  /// In en, this message translates to:
  /// **'Updating...'**
  String get reset_password_loading;

  /// No description provided for @validation_passwords_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get validation_passwords_not_match;

  /// ----- CIMBIL AI PAGE -----
  ///
  /// In en, this message translates to:
  /// **'Cimbil'**
  String get cimbil_title;

  /// No description provided for @cimbil_greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello! I\'m Cimbil 👋'**
  String get cimbil_greeting;

  /// No description provided for @cimbil_description.
  ///
  /// In en, this message translates to:
  /// **'Ask me anything about nutrition.\nCalculate calories, get recipes, ask for advice!'**
  String get cimbil_description;

  /// No description provided for @cimbil_input_hint.
  ///
  /// In en, this message translates to:
  /// **'Ask Cimbil something...'**
  String get cimbil_input_hint;

  /// No description provided for @cimbil_suggestion_calorie.
  ///
  /// In en, this message translates to:
  /// **'🍕 How many calories?'**
  String get cimbil_suggestion_calorie;

  /// No description provided for @cimbil_suggestion_recipe.
  ///
  /// In en, this message translates to:
  /// **'🥗 Suggest a healthy recipe'**
  String get cimbil_suggestion_recipe;

  /// No description provided for @cimbil_suggestion_protein.
  ///
  /// In en, this message translates to:
  /// **'💪 Protein sources'**
  String get cimbil_suggestion_protein;

  /// No description provided for @cimbil_query_calorie.
  ///
  /// In en, this message translates to:
  /// **'How many calories does this food have?'**
  String get cimbil_query_calorie;

  /// No description provided for @cimbil_query_recipe.
  ///
  /// In en, this message translates to:
  /// **'Can you suggest a healthy recipe?'**
  String get cimbil_query_recipe;

  /// No description provided for @cimbil_query_protein.
  ///
  /// In en, this message translates to:
  /// **'What are the best protein sources?'**
  String get cimbil_query_protein;

  /// No description provided for @cimbil_not_active.
  ///
  /// In en, this message translates to:
  /// **'This feature is not active yet, I\'ll be here very soon! 🤖'**
  String get cimbil_not_active;

  /// ----- NUTRITION RESULT PAGE -----
  ///
  /// In en, this message translates to:
  /// **'Product Info'**
  String get nutrition_title_barcode;

  /// No description provided for @nutrition_title_food.
  ///
  /// In en, this message translates to:
  /// **'Food Analysis'**
  String get nutrition_title_food;

  /// No description provided for @nutrition_kcal_suffix.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get nutrition_kcal_suffix;

  /// No description provided for @nutrition_portion_single.
  ///
  /// In en, this message translates to:
  /// **'1 serving'**
  String get nutrition_portion_single;

  /// No description provided for @nutrition_portion_estimated.
  ///
  /// In en, this message translates to:
  /// **'Estimated serving'**
  String get nutrition_portion_estimated;

  /// No description provided for @nutrition_add_to_log.
  ///
  /// In en, this message translates to:
  /// **'Add to Log'**
  String get nutrition_add_to_log;

  /// No description provided for @nutrition_fat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get nutrition_fat;

  /// No description provided for @nutrition_protein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get nutrition_protein;

  /// No description provided for @nutrition_carb.
  ///
  /// In en, this message translates to:
  /// **'Carbohydrate'**
  String get nutrition_carb;

  /// No description provided for @nutrition_fiber.
  ///
  /// In en, this message translates to:
  /// **'Fiber'**
  String get nutrition_fiber;

  /// ----- BARCODE SCANNER PAGE -----
  ///
  /// In en, this message translates to:
  /// **'Scan barcode...'**
  String get scanner_barcode_scanning;

  /// No description provided for @scanner_barcode_align.
  ///
  /// In en, this message translates to:
  /// **'Align the barcode within the frame'**
  String get scanner_barcode_align;

  /// No description provided for @scanner_barcode_found.
  ///
  /// In en, this message translates to:
  /// **'Barcode scanned!'**
  String get scanner_barcode_found;

  /// No description provided for @scanner_barcode_rescan.
  ///
  /// In en, this message translates to:
  /// **'Rescan'**
  String get scanner_barcode_rescan;

  /// No description provided for @scanner_querying.
  ///
  /// In en, this message translates to:
  /// **'Querying...'**
  String get scanner_querying;

  /// No description provided for @scanner_querying_detail.
  ///
  /// In en, this message translates to:
  /// **'Fetching product info'**
  String get scanner_querying_detail;

  /// No description provided for @scanner_food_mode.
  ///
  /// In en, this message translates to:
  /// **'Food Mode'**
  String get scanner_food_mode;

  /// No description provided for @scanner_food_align.
  ///
  /// In en, this message translates to:
  /// **'Align the plate here'**
  String get scanner_food_align;

  /// No description provided for @scanner_food_instruction.
  ///
  /// In en, this message translates to:
  /// **'For more accurate results, place your thumb next to the plate and take the photo 👍'**
  String get scanner_food_instruction;

  /// No description provided for @scanner_tab_barcode.
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get scanner_tab_barcode;

  /// No description provided for @scanner_tab_food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get scanner_tab_food;

  /// No description provided for @scanner_tab_ask_ai.
  ///
  /// In en, this message translates to:
  /// **'Ask Cimbil'**
  String get scanner_tab_ask_ai;

  /// ----- FORM PAGES -----
  ///
  /// In en, this message translates to:
  /// **'Let\'s start with a few questions!'**
  String get form_intro_title;

  /// No description provided for @form_username_title.
  ///
  /// In en, this message translates to:
  /// **'What should your username be?'**
  String get form_username_title;

  /// No description provided for @form_username_hint.
  ///
  /// In en, this message translates to:
  /// **'username'**
  String get form_username_hint;

  /// No description provided for @form_goal_title.
  ///
  /// In en, this message translates to:
  /// **'What is your main goal?'**
  String get form_goal_title;

  /// No description provided for @form_goal_lose_weight.
  ///
  /// In en, this message translates to:
  /// **'Lose weight'**
  String get form_goal_lose_weight;

  /// No description provided for @form_goal_gain_weight.
  ///
  /// In en, this message translates to:
  /// **'Gain weight'**
  String get form_goal_gain_weight;

  /// No description provided for @form_goal_maintain_weight.
  ///
  /// In en, this message translates to:
  /// **'Maintain current weight'**
  String get form_goal_maintain_weight;

  /// No description provided for @form_goal_build_muscle.
  ///
  /// In en, this message translates to:
  /// **'Build muscle'**
  String get form_goal_build_muscle;

  /// No description provided for @form_gender_title.
  ///
  /// In en, this message translates to:
  /// **'What is your gender?'**
  String get form_gender_title;

  /// No description provided for @form_gender_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get form_gender_male;

  /// No description provided for @form_gender_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get form_gender_female;

  /// No description provided for @form_gender_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get form_gender_other;

  /// No description provided for @form_age_title.
  ///
  /// In en, this message translates to:
  /// **'How old are you?'**
  String get form_age_title;

  /// No description provided for @form_age_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your age'**
  String get form_age_hint;

  /// No description provided for @form_age_unit.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get form_age_unit;

  /// No description provided for @form_body_title.
  ///
  /// In en, this message translates to:
  /// **'Enter your height and weight'**
  String get form_body_title;

  /// No description provided for @form_height_hint.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get form_height_hint;

  /// No description provided for @form_weight_hint.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get form_weight_hint;

  /// No description provided for @form_height_unit.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get form_height_unit;

  /// No description provided for @form_weight_unit.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get form_weight_unit;

  /// No description provided for @form_activity_title.
  ///
  /// In en, this message translates to:
  /// **'Select your activity level'**
  String get form_activity_title;

  /// No description provided for @form_activity_info_title.
  ///
  /// In en, this message translates to:
  /// **'What is activity level?'**
  String get form_activity_info_title;

  /// No description provided for @form_activity_info_desc.
  ///
  /// In en, this message translates to:
  /// **'Your activity level is used to calculate your daily calorie needs.\n\n• Sedentary: Desk job, little movement\n• Lightly Active: Light exercise 1-3 days/week\n• Moderately Active: Moderate exercise 3-5 days/week\n• Very Active: Intense exercise 6-7 days/week'**
  String get form_activity_info_desc;

  /// No description provided for @form_activity_sedentary.
  ///
  /// In en, this message translates to:
  /// **'Sedentary'**
  String get form_activity_sedentary;

  /// No description provided for @form_activity_lightly_active.
  ///
  /// In en, this message translates to:
  /// **'Lightly Active'**
  String get form_activity_lightly_active;

  /// No description provided for @form_activity_moderately_active.
  ///
  /// In en, this message translates to:
  /// **'Moderately Active'**
  String get form_activity_moderately_active;

  /// No description provided for @form_activity_very_active.
  ///
  /// In en, this message translates to:
  /// **'Very Active'**
  String get form_activity_very_active;

  /// No description provided for @form_allergies_title.
  ///
  /// In en, this message translates to:
  /// **'Do you have any allergies?'**
  String get form_allergies_title;

  /// No description provided for @form_allergy_gluten.
  ///
  /// In en, this message translates to:
  /// **'Gluten'**
  String get form_allergy_gluten;

  /// No description provided for @form_allergy_dairy.
  ///
  /// In en, this message translates to:
  /// **'Dairy/Lactose'**
  String get form_allergy_dairy;

  /// No description provided for @form_allergy_eggs.
  ///
  /// In en, this message translates to:
  /// **'Eggs'**
  String get form_allergy_eggs;

  /// No description provided for @form_allergy_nuts.
  ///
  /// In en, this message translates to:
  /// **'Tree Nuts'**
  String get form_allergy_nuts;

  /// No description provided for @form_allergy_soy.
  ///
  /// In en, this message translates to:
  /// **'Soy'**
  String get form_allergy_soy;

  /// No description provided for @form_allergy_fish.
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get form_allergy_fish;

  /// No description provided for @form_allergy_shellfish.
  ///
  /// In en, this message translates to:
  /// **'Shellfish'**
  String get form_allergy_shellfish;

  /// No description provided for @form_allergy_peanuts.
  ///
  /// In en, this message translates to:
  /// **'Peanuts'**
  String get form_allergy_peanuts;

  /// No description provided for @form_health_title.
  ///
  /// In en, this message translates to:
  /// **'Do you have any health conditions?'**
  String get form_health_title;

  /// No description provided for @form_health_diabetes.
  ///
  /// In en, this message translates to:
  /// **'Diabetes'**
  String get form_health_diabetes;

  /// No description provided for @form_health_hypertension.
  ///
  /// In en, this message translates to:
  /// **'Hypertension'**
  String get form_health_hypertension;

  /// No description provided for @form_health_heart_disease.
  ///
  /// In en, this message translates to:
  /// **'Heart Disease'**
  String get form_health_heart_disease;

  /// No description provided for @form_health_celiac.
  ///
  /// In en, this message translates to:
  /// **'Celiac'**
  String get form_health_celiac;

  /// No description provided for @form_health_high_cholesterol.
  ///
  /// In en, this message translates to:
  /// **'High Cholesterol'**
  String get form_health_high_cholesterol;

  /// No description provided for @form_health_obesity.
  ///
  /// In en, this message translates to:
  /// **'Obesity'**
  String get form_health_obesity;

  /// No description provided for @form_validation_answer_required.
  ///
  /// In en, this message translates to:
  /// **'Please answer this question'**
  String get form_validation_answer_required;

  /// No description provided for @form_validation_both_fields_required.
  ///
  /// In en, this message translates to:
  /// **'Please fill in both fields'**
  String get form_validation_both_fields_required;

  /// ----- HOME PAGE -----
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get home_greeting;

  /// No description provided for @home_default_user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get home_default_user;

  /// No description provided for @home_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get home_retry;

  /// No description provided for @home_daily_summary.
  ///
  /// In en, this message translates to:
  /// **'Daily Summary'**
  String get home_daily_summary;

  /// No description provided for @home_details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get home_details;

  /// No description provided for @home_health_data.
  ///
  /// In en, this message translates to:
  /// **'Health Data'**
  String get home_health_data;

  /// No description provided for @home_calorie.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get home_calorie;

  /// No description provided for @home_water_progress.
  ///
  /// In en, this message translates to:
  /// **'progress'**
  String get home_water_progress;

  /// No description provided for @home_stat_steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get home_stat_steps;

  /// No description provided for @home_stat_sleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get home_stat_sleep;

  /// No description provided for @home_stat_bpm.
  ///
  /// In en, this message translates to:
  /// **'BPM'**
  String get home_stat_bpm;

  /// ----- NAVIGATION -----
  ///
  /// In en, this message translates to:
  /// **'Ask Cimbil AI anything...'**
  String get nav_ai_prompt;

  /// ----- PROFILE PAGE -----
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @profile_body_info_title.
  ///
  /// In en, this message translates to:
  /// **'Body Info'**
  String get profile_body_info_title;

  /// No description provided for @profile_height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get profile_height;

  /// No description provided for @profile_weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get profile_weight;

  /// No description provided for @profile_age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get profile_age;

  /// No description provided for @profile_age_unit.
  ///
  /// In en, this message translates to:
  /// **'y/o'**
  String get profile_age_unit;

  /// No description provided for @profile_gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get profile_gender;

  /// No description provided for @profile_not_specified.
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get profile_not_specified;

  /// No description provided for @profile_gender_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get profile_gender_male;

  /// No description provided for @profile_gender_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get profile_gender_female;

  /// No description provided for @profile_gender_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get profile_gender_other;

  /// No description provided for @profile_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profile_notifications;

  /// No description provided for @profile_sync_health.
  ///
  /// In en, this message translates to:
  /// **'Sync Health Data'**
  String get profile_sync_health;

  /// No description provided for @profile_logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get profile_logout;

  /// No description provided for @profile_logout_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get profile_logout_confirm_title;

  /// No description provided for @profile_logout_confirm_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get profile_logout_confirm_message;

  /// No description provided for @profile_logout_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profile_logout_cancel;

  /// No description provided for @profile_logout_confirm.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get profile_logout_confirm;

  /// No description provided for @profile_error_prefix.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get profile_error_prefix;

  /// No description provided for @profile_streak_days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get profile_streak_days;
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
