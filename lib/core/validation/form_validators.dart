import 'package:project_a/l10n/app_localizations.dart';

class FormValidators {
  static final RegExp _namePattern = RegExp(r"^[a-zA-ZçÇğĞıİöÖşŞüÜ\s'-]+$");

  static String? firstName(String? value, AppLocalizations l10n) {
    final firstName = value?.trim() ?? '';
    if (firstName.isEmpty) {
      return l10n.validation_first_name_required;
    }
    if (!_namePattern.hasMatch(firstName)) {
      return l10n.validation_first_name_invalid;
    }
    return null;
  }

  static String? lastName(String? value, AppLocalizations l10n) {
    final lastName = value?.trim() ?? '';
    if (lastName.isEmpty) {
      return l10n.validation_last_name_required;
    }
    if (!_namePattern.hasMatch(lastName)) {
      return l10n.validation_last_name_invalid;
    }
    return null;
  }

  static String? email(String? value, AppLocalizations l10n) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return l10n.validation_email_required;
    }

    const pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    if (!RegExp(pattern).hasMatch(email)) {
      return l10n.validation_email_invalid;
    }

    return null;
  }

  static String? password(
    String? value,
    AppLocalizations l10n, {
    int minLength = 6,
  }) {
    final password = value ?? '';
    if (password.isEmpty) {
      return l10n.validation_password_required;
    }
    if (password.length < minLength) {
      return l10n.validation_password_min_length;
    }
    return null;
  }
}
