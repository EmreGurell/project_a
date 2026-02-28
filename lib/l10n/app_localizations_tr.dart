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
  String get forgot_password_title => 'Şifreni Mi Unuttun?';

  @override
  String get forgot_password_subtitle =>
      'E-posta adresini gir, sana kod gönderelim';

  @override
  String get forgot_password_send_code => 'Kod Gönder';

  @override
  String get forgot_password_sending => 'Gönderiliyor...';

  @override
  String get back_to_login => 'Giriş sayfasına dön';

  @override
  String get verify_account_title => 'Kodu Doğrula';

  @override
  String get verify_account_subtitle =>
      'E-posta adresine gönderilen 6 haneli kodu gir';

  @override
  String get verify_account_code_label => 'Doğrulama Kodu';

  @override
  String get verify_account_sent_to => 'Kod şu adrese gönderildi:';

  @override
  String get verify_account_button => 'Doğrula';

  @override
  String get verify_account_loading => 'Doğrulanıyor...';

  @override
  String get verify_account_resend => 'Kodu tekrar gönder';

  @override
  String get verify_account_resend_loading => 'Gönderiliyor...';

  @override
  String get validation_code_required => 'Doğrulama kodu zorunludur.';

  @override
  String get validation_code_length => 'Kod 6 haneli olmalıdır.';

  @override
  String get reset_password_title => 'Yeni Şifre Belirle';

  @override
  String get reset_password_subtitle => 'Güçlü bir şifre seç';

  @override
  String get reset_password_new_label => 'Yeni Şifre';

  @override
  String get reset_password_confirm_label => 'Şifre Tekrarı';

  @override
  String get reset_password_button => 'Şifreyi Güncelle';

  @override
  String get reset_password_loading => 'Güncelleniyor...';

  @override
  String get validation_passwords_not_match => 'Şifreler eşleşmiyor.';

  @override
  String get cimbil_title => 'Cımbıl';

  @override
  String get cimbil_greeting => 'Merhaba! Ben Cımbıl 👋';

  @override
  String get cimbil_description =>
      'Beslenme hakkında her şeyi sorabilirsin.\nKalori hesapla, tarif al, öneri iste!';

  @override
  String get cimbil_input_hint => 'Cımbıl\'a bir şey sor...';

  @override
  String get cimbil_suggestion_calorie => '🍕 Bu yemeğin kalorisi?';

  @override
  String get cimbil_suggestion_recipe => '🥗 Sağlıklı tarif öner';

  @override
  String get cimbil_suggestion_protein => '💪 Protein kaynakları';

  @override
  String get cimbil_query_calorie => 'Bu yemeğin kalorisi ne kadar?';

  @override
  String get cimbil_query_recipe => 'Sağlıklı bir tarif önerir misin?';

  @override
  String get cimbil_query_protein => 'En iyi protein kaynakları neler?';

  @override
  String get cimbil_not_active =>
      'Henüz bu özellik aktif değil, çok yakında burada olacağım! 🤖';

  @override
  String get nutrition_title_barcode => 'Ürün Bilgisi';

  @override
  String get nutrition_title_food => 'Yemek Analizi';

  @override
  String get nutrition_kcal_suffix => 'kcal';

  @override
  String get nutrition_portion_single => '1 porsiyon';

  @override
  String get nutrition_portion_estimated => 'Tahmini porsiyon';

  @override
  String get nutrition_add_to_log => 'Günlüğe Ekle';

  @override
  String get nutrition_fat => 'Yağ';

  @override
  String get nutrition_protein => 'Protein';

  @override
  String get nutrition_carb => 'Karbonhidrat';

  @override
  String get nutrition_fiber => 'Lif';

  @override
  String get scanner_barcode_scanning => 'Barkod okutun...';

  @override
  String get scanner_barcode_align => 'Barkodu çerçeve içine hizalayın';

  @override
  String get scanner_barcode_found => 'Barkod okundu!';

  @override
  String get scanner_barcode_rescan => 'Tekrar';

  @override
  String get scanner_querying => 'Sorgulanıyor...';

  @override
  String get scanner_querying_detail => 'Ürün bilgileri getiriliyor';

  @override
  String get scanner_food_mode => 'Yemek Modu';

  @override
  String get scanner_food_align => 'Tabağı buraya hizalayın';

  @override
  String get scanner_food_instruction =>
      'Daha doğru sonuç için baş parmağınızı tabağın yanına koyun ve fotoğrafı çekin 👍';

  @override
  String get scanner_tab_barcode => 'Barkod';

  @override
  String get scanner_tab_food => 'Yemek';

  @override
  String get scanner_tab_ask_ai => 'Cımbıla Sor';
}
