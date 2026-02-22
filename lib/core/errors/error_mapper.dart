import 'package:flutter/material.dart';
import 'package:project_a/l10n/app_localizations.dart';

class ErrorMapper {
  static String getErrorMessage(BuildContext context, String serverErrorCode) {
    final l10n = AppLocalizations.of(context);

    if (l10n == null) return "Dil yüklenemedi";

    switch (serverErrorCode) {
      case "INVALID_CREDENTIALS":
        return l10n.error_invalid_credentials;

      case "USER_NOT_FOUND":
        return l10n.error_user_not_found;

      case "VALIDATION_ERROR":
        return l10n.error_validation_error;

      case "UNAUTHORIZED":
        return l10n.error_unauthorized;

      case "TOKEN_EXPIRED":
        return l10n.error_token_expired;

      case "INVALID_TOKEN":
        return l10n.error_invalid_token;

      case "USER_ALREADY_EXISTS":
        return l10n.error_user_already_exists;

      case "INVALID_RESPONSE":
        return l10n.error_invalid_response;

      case "NETWORK_ERROR":
        return l10n.error_network_error;

      default:
        return "${l10n.error_unknown} $serverErrorCode";
    }
  }
}
