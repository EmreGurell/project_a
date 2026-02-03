/// Base exception class for server-related errors
class ServerException implements Exception {
  final String code;

  ServerException(this.code);

  String get message {
    switch (code) {
      case 'internal_server_error':
        return 'Sunucu hatası oluştu. Lütfen daha sonra tekrar deneyin.';
      case 'service_unavailable':
        return 'Hizmet şu anda kullanılamıyor. Lütfen daha sonra tekrar deneyin.';
      case 'bad_gateway':
        return 'Ağ geçidi hatası. Lütfen bağlantınızı kontrol edin.';
      default:
        return 'Sunucu hatası oluştu. Lütfen tekrar deneyin.';
    }
  }

  @override
  String toString() => message;
}

/// Authentication and authorization related exceptions
class AuthenticationException implements Exception {
  final String code;

  AuthenticationException(this.code);

  String get message {
    switch (code) {
      case 'invalid_credentials':
        return 'Geçersiz e-posta veya şifre.';
      case 'user_not_found':
        return 'Kullanıcı bulunamadı. Lütfen kayıt olunuz.';
      case 'user_already_exists':
        return 'Bu e-posta adresiyle zaten bir hesap mevcut.';
      case 'weak_password':
        return 'Şifre en az 6 karakter olmalıdır.';
      case 'invalid_email':
        return 'Geçersiz e-posta adresi.';
      case 'email_not_verified':
        return 'E-posta adresiniz henüz doğrulanmadı.';
      case 'account_disabled':
        return 'Bu hesap devre dışı bırakılmıştır.';
      default:
        return 'Kimlik doğrulama hatası oluştu.';
    }
  }

  @override
  String toString() => message;
}

/// Authorization related exceptions
class AuthorizationException implements Exception {
  final String code;

  AuthorizationException(this.code);

  String get message {
    switch (code) {
      case 'permission_denied':
        return 'Bu işlemi gerçekleştirme izniniz yok.';
      case 'insufficient_permissions':
        return 'Yeterli izin bulunmuyor.';
      case 'token_expired':
        return 'Oturum süreniz dolmuş. Lütfen tekrar giriş yapınız.';
      case 'invalid_token':
        return 'Geçersiz oturum. Lütfen tekrar giriş yapınız.';
      default:
        return 'Yetkilendirme hatası oluştu.';
    }
  }

  @override
  String toString() => message;
}

/// Validation related exceptions
class ValidationException implements Exception {
  final String code;
  final String? field;

  ValidationException(this.code, {this.field});

  String get message {
    switch (code) {
      case 'invalid_format':
        return 'Geçersiz veri formatı. ${field != null ? 'Alan: $field' : ''}';
      case 'missing_field':
        return 'Gerekli alan eksik. ${field != null ? 'Alan: $field' : ''}';
      case 'invalid_length':
        return 'Geçersiz uzunluk. ${field != null ? 'Alan: $field' : ''}';
      case 'duplicate_entry':
        return '${field != null ? '$field' : 'Bu'} zaten kayıtlı.';
      case 'invalid_value':
        return 'Geçersiz değer. ${field != null ? 'Alan: $field' : ''}';
      default:
        return 'Doğrulama hatası oluştu.';
    }
  }

  @override
  String toString() => message;
}

/// Network related exceptions
class NetworkException implements Exception {
  final String code;

  NetworkException(this.code);

  String get message {
    switch (code) {
      case 'no_internet':
        return 'İnternet bağlantısı yok. Lütfen bağlantınızı kontrol edin.';
      case 'timeout':
        return 'İstek zaman aşımına uğradı. Lütfen tekrar deneyin.';
      case 'connection_error':
        return 'Bağlantı hatası. Lütfen bağlantınızı kontrol edin.';
      case 'socket_exception':
        return 'Ağ bağlantısı hatası oluştu.';
      case 'certificate_error':
        return 'Güvenlik sertifikası hatası.';
      default:
        return 'Ağ hatası oluştu. Lütfen tekrar deneyin.';
    }
  }

  @override
  String toString() => message;
}

/// Data parsing and deserialization exceptions
class ParseException implements Exception {
  final String code;

  ParseException(this.code);

  String get message {
    switch (code) {
      case 'invalid_json':
        return 'Geçersiz JSON formatı.';
      case 'missing_key':
        return 'Gerekli alan sunucu yanıtında bulunamadı.';
      case 'type_mismatch':
        return 'Veri tipi uyuşmazlığı.';
      case 'null_value':
        return 'Beklenmeyen null değer.';
      default:
        return 'Veri işleme hatası oluştu.';
    }
  }

  @override
  String toString() => message;
}

/// Business logic related exceptions
class BusinessException implements Exception {
  final String code;

  BusinessException(this.code);

  String get message {
    switch (code) {
      case 'resource_not_found':
        return 'İstenen kaynak bulunamadı.';
      case 'resource_already_exists':
        return 'Bu kaynak zaten mevcut.';
      case 'invalid_operation':
        return 'Bu işlem gerçekleştirilemez.';
      case 'operation_failed':
        return 'İşlem başarısız oldu. Lütfen tekrar deneyin.';
      case 'insufficient_balance':
        return 'Yeterli bakiye bulunmuyor.';
      default:
        return 'İşlem gerçekleştirilemedi.';
    }
  }

  @override
  String toString() => message;
}

/// General/Unknown exceptions
class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);

  @override
  String toString() => message;
}
