// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get error_invalid_credentials =>
      'User email or password is incorrect!';

  @override
  String get error_user_not_found => 'No user found with this email.';

  @override
  String get error_unknown => 'An unknown error occurred. Please try again.';

  @override
  String get error_validation_error =>
      'Validation error occurred. Please try again.';

  @override
  String get error_unauthorized => 'Unauthorized. Please try again.';

  @override
  String get error_token_expired => 'Token expired. Please try again.';

  @override
  String get error_invalid_token => 'Invalid token. Please try again.';

  @override
  String get error_not_found => 'Not found. Please try again.';

  @override
  String get error_user_already_exists =>
      'User already exists. Please try again.';

  @override
  String get error_invalid_response =>
      'Unexpected response received from server. Please try again.';

  @override
  String get error_network_error =>
      'Network error. Please check your connection and try again.';

  @override
  String get onboarding_title_1 => 'Take a photo, let Cimbil calculate';

  @override
  String get onboarding_desc_1 =>
      'Take a picture of your meal. AI \"Cimbil\" recognizes it and estimates calories.';

  @override
  String get onboarding_title_2 => 'Track calories, stay in shape!';

  @override
  String get onboarding_desc_2 =>
      'Save calories for each meal and automatically calculate your daily totals.';

  @override
  String get onboarding_title_3 => 'Make smarter choices';

  @override
  String get onboarding_desc_3 =>
      'Stay balanced with daily alerts and summaries. See what to reduce based on your goal.';

  @override
  String get onboarding_skip => 'Skip';

  @override
  String get onboarding_next => 'Next';

  @override
  String get onboarding_lets_start => 'Let\'s Start';

  @override
  String get welcome => 'Welcome Back';

  @override
  String get good_to_see_you => 'Good to see you';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get sign_in => 'Sign In';

  @override
  String get sign_in_loading => 'Signing in...';

  @override
  String get continue_with_google => 'Sign in with Google';

  @override
  String get forgot_password => 'Forgot password?';

  @override
  String get dont_have_account => 'Don\'t have an account?';

  @override
  String get create_account => 'Create account';

  @override
  String get validation_email_required => 'Email is required.';

  @override
  String get validation_email_invalid => 'Please enter a valid email address.';

  @override
  String get validation_password_required => 'Password is required.';

  @override
  String get validation_password_min_length =>
      'Password must be at least 6 characters.';

  @override
  String get validation_first_name_required => 'First name is required.';

  @override
  String get validation_last_name_required => 'Last name is required.';

  @override
  String get validation_first_name_invalid =>
      'First name cannot contain numbers or special characters.';

  @override
  String get validation_last_name_invalid =>
      'Last name cannot contain numbers or special characters.';

  @override
  String get register_title => 'Let\'s Get Started';

  @override
  String get register_subtitle => 'You can start by creating your account';

  @override
  String get register_first_name_label => 'First Name';

  @override
  String get register_last_name_label => 'Last Name';

  @override
  String get register_button => 'Sign Up';

  @override
  String get register_have_account => 'Already have an account? Sign In';

  @override
  String get forgot_password_title => 'Forgot Your Password?';

  @override
  String get forgot_password_subtitle =>
      'Enter your email and we\'ll send you a code';

  @override
  String get forgot_password_send_code => 'Send Code';

  @override
  String get forgot_password_sending => 'Sending...';

  @override
  String get back_to_login => 'Back to login';

  @override
  String get verify_account_title => 'Verify Code';

  @override
  String get verify_account_subtitle =>
      'Enter the 6-digit code sent to your email';

  @override
  String get verify_account_code_label => 'Verification Code';

  @override
  String get verify_account_sent_to => 'Code sent to:';

  @override
  String get verify_account_button => 'Verify';

  @override
  String get verify_account_loading => 'Verifying...';

  @override
  String get verify_account_resend => 'Resend code';

  @override
  String get verify_account_resend_loading => 'Sending...';

  @override
  String get validation_code_required => 'Verification code is required.';

  @override
  String get validation_code_length => 'Code must be 6 digits.';

  @override
  String get reset_password_title => 'Set New Password';

  @override
  String get reset_password_subtitle => 'Choose a strong password';

  @override
  String get reset_password_new_label => 'New Password';

  @override
  String get reset_password_confirm_label => 'Confirm Password';

  @override
  String get reset_password_button => 'Update Password';

  @override
  String get reset_password_loading => 'Updating...';

  @override
  String get validation_passwords_not_match => 'Passwords do not match.';

  @override
  String get cimbil_title => 'Cimbil';

  @override
  String get cimbil_greeting => 'Hello! I\'m Cimbil 👋';

  @override
  String get cimbil_description =>
      'Ask me anything about nutrition.\nCalculate calories, get recipes, ask for advice!';

  @override
  String get cimbil_input_hint => 'Ask Cimbil something...';

  @override
  String get cimbil_suggestion_calorie => '🍕 How many calories?';

  @override
  String get cimbil_suggestion_recipe => '🥗 Suggest a healthy recipe';

  @override
  String get cimbil_suggestion_protein => '💪 Protein sources';

  @override
  String get cimbil_query_calorie => 'How many calories does this food have?';

  @override
  String get cimbil_query_recipe => 'Can you suggest a healthy recipe?';

  @override
  String get cimbil_query_protein => 'What are the best protein sources?';

  @override
  String get cimbil_not_active =>
      'This feature is not active yet, I\'ll be here very soon! 🤖';

  @override
  String get nutrition_title_barcode => 'Product Info';

  @override
  String get nutrition_title_food => 'Food Analysis';

  @override
  String get nutrition_kcal_suffix => 'kcal';

  @override
  String get nutrition_portion_single => '1 serving';

  @override
  String get nutrition_portion_estimated => 'Estimated serving';

  @override
  String get nutrition_add_to_log => 'Add to Log';

  @override
  String get nutrition_fat => 'Fat';

  @override
  String get nutrition_protein => 'Protein';

  @override
  String get nutrition_carb => 'Carbohydrate';

  @override
  String get nutrition_fiber => 'Fiber';

  @override
  String get scanner_barcode_scanning => 'Scan barcode...';

  @override
  String get scanner_barcode_align => 'Align the barcode within the frame';

  @override
  String get scanner_barcode_found => 'Barcode scanned!';

  @override
  String get scanner_barcode_rescan => 'Rescan';

  @override
  String get scanner_querying => 'Querying...';

  @override
  String get scanner_querying_detail => 'Fetching product info';

  @override
  String get scanner_food_mode => 'Food Mode';

  @override
  String get scanner_food_align => 'Align the plate here';

  @override
  String get scanner_food_instruction =>
      'For more accurate results, place your thumb next to the plate and take the photo 👍';

  @override
  String get scanner_tab_barcode => 'Barcode';

  @override
  String get scanner_tab_food => 'Food';

  @override
  String get scanner_tab_ask_ai => 'Ask Cimbil';
}
