import 'package:project_a/features/onboarding/domain/models/onboarding_page.dart';

class OnboardingPagesData {
  OnboardingPagesData._();

  static const List<OnBoardingPage> pages = [
    OnBoardingPage(
      image: 'assets/images/onboarding_image_1.png',
      title: 'Fotoğraf çek, Cımbıl hesaplasın',
      description:
          'Yemeğini çek. Yapay zeka "Cımbıl" tanır ve yaklaşık kalori hesabını çıkarır.',
    ),
    OnBoardingPage(
      image: 'assets/images/onboarding_image_2.png',
      title: 'Kalori takibi yap, Göbüş Gitsin!',
      description:
          'Her öğünün kalorisini kaydet. Günlük toplamlarını otomatik hesapla.',
    ),
    OnBoardingPage(
      image: 'assets/images/onboarding_image_3.png',
      title: 'Daha bilinçli seçimler yap',
      description:
          'Gün içi uyarılar ve özetlerle dengede kal. Hedefine göre neyi azaltman gerektiğini gör.',
    ),
  ];
}
