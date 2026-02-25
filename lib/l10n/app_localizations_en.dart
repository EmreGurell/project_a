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
  String get hello => 'Hello';
}
