// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get error_invalid_credentials =>
      'Kullanıcı adı veya şifreyi hatalı girdiniz.';

  @override
  String get error_user_not_found =>
      'Bu e-posta adresiyle kayıtlı bir kullanıcı bulunamadı.';

  @override
  String get error_unknown =>
      'Bilinmeyen bir hata oluştu. Lütfen tekrar deneyin.';

  @override
  String get error_validation_error =>
      'Doğrulama hatası oluştu. Lütfen tekrar deneyin.';

  @override
  String get error_unauthorized => 'Yetkisiz işlem. Lütfen tekrar deneyin.';

  @override
  String get error_token_expired =>
      'Oturum süresi doldu. Lütfen tekrar giriş yapın.';

  @override
  String get error_invalid_token =>
      'Geçersiz oturum bilgisi. Lütfen tekrar giriş yapın.';

  @override
  String get error_not_found => 'Aradığınız kayıt bulunamadı.';

  @override
  String get error_user_already_exists => 'Bu kullanıcı zaten mevcut.';

  @override
  String get error_invalid_response =>
      'Sunucudan beklenmeyen bir yanıt alındı. Lütfen tekrar deneyin.';

  @override
  String get error_network_error =>
      'Ağ hatası oluştu. Bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String get onboarding_title_1 => 'Fotoğraf çek, Cımbıl hesaplasın';

  @override
  String get onboarding_desc_1 =>
      'Yemeğini çek. Yapay zeka \"Cımbıl\" tanır ve yaklaşık kalori hesabını çıkarır.';

  @override
  String get onboarding_title_2 => 'Kalori takibi yap, Göbüş Gitsin!';

  @override
  String get onboarding_desc_2 =>
      'Her öğünün kalorisini kaydet. Günlük toplamlarını otomatik hesapla.';

  @override
  String get onboarding_title_3 => 'Daha bilinçli seçimler yap';

  @override
  String get onboarding_desc_3 =>
      'Gün içi uyarılar ve özetlerle dengede kal. Hedefine göre neyi azaltman gerektiğini gör.';

  @override
  String get onboarding_skip => 'Geç';

  @override
  String get onboarding_next => 'İleri';

  @override
  String get onboarding_lets_start => 'Başlayalım';

  @override
  String get welcome => 'Tekrar Hoş Geldin';

  @override
  String get good_to_see_you => 'Seni görmek güzel';

  @override
  String get email => 'E-posta';

  @override
  String get password => 'Şifre';

  @override
  String get sign_in => 'Giriş Yap';

  @override
  String get sign_in_loading => 'Giriş yapılıyor...';

  @override
  String get continue_with_google => 'Google ile giriş yap';

  @override
  String get forgot_password => 'Şifreni mi unuttun?';

  @override
  String get dont_have_account => 'Hesabın yok mu?';

  @override
  String get create_account => 'Hesap oluştur';

  @override
  String get validation_email_required => 'E-posta zorunludur.';

  @override
  String get validation_email_invalid =>
      'Lütfen geçerli bir e-posta adresi girin.';

  @override
  String get validation_password_required => 'Şifre zorunludur.';

  @override
  String get validation_password_min_length =>
      'Şifre en az 6 karakter olmalıdır.';

  @override
  String get validation_first_name_required => 'İsim zorunludur.';

  @override
  String get validation_last_name_required => 'Soyisim zorunludur.';

  @override
  String get validation_first_name_invalid =>
      'İsim alanında sayı veya özel karakter kullanılamaz.';

  @override
  String get validation_last_name_invalid =>
      'Soyisim alanında sayı veya özel karakter kullanılamaz.';

  @override
  String get register_title => 'Hadi Başlayalım';

  @override
  String get register_subtitle => 'Hesap oluşturarak başlayabilirsin';

  @override
  String get register_first_name_label => 'İsim';

  @override
  String get register_last_name_label => 'Soyisim';

  @override
  String get register_button => 'Kayıt Ol';

  @override
  String get register_have_account => 'Hesabın var mı? Giriş Yap';

  @override
  String get hello => 'Merhaba';
}
