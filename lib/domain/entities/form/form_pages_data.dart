import 'package:flutter/material.dart';
import 'package:project_a/data/models/form/form_pages_model.dart';
import 'package:project_a/utils/constants/image_paths.dart';

class FormPagesData {
  FormPagesData._();

  static final List<FormPagesModel> pages = [
    // 1 — Intro
    FormPagesModel(
      formType: FormType.image,
      hasAdditionalInfo: false,
      title: "Önce bir kaç soruyla başlayalım!",
      image: ImageAndAnimationPaths.form1,
      isRequired: false,
    ),
    // 2 — Kullanıcı adı
    FormPagesModel(
      formType: FormType.text,
      hasAdditionalInfo: false,
      title: "Kullanıcı adın ne olsun?",
      fieldKey: "username",
      hint: "kullanici_adi",
      inputType: TextInputType.text,
    ),
    // 3 — Hedef
    FormPagesModel(
      formType: FormType.choice,
      hasAdditionalInfo: false,
      title: "Ana hedefin ne?",
      fieldKey: "goal",
      choices: [
        "Kilo vermek",
        "Kilo almak",
        "Mevcut kiloyu korumak",
        "Kas Yapmak",
      ],
    ),
    // 4 — Cinsiyet
    FormPagesModel(
      formType: FormType.choice,
      hasAdditionalInfo: false,
      title: "Cinsiyetin nedir?",
      fieldKey: "gender",
      choices: ["Erkek", "Kadın", "Diğer"],
    ),
    // 5 — Yaş
    FormPagesModel(
      formType: FormType.text,
      hasAdditionalInfo: false,
      title: "Kaç yaşındasın?",
      fieldKey: "age",
      hint: "Yaşını gir",
      unit: "yaş",
      inputType: TextInputType.number,
    ),
    // 6 — Boy + Kilo
    FormPagesModel(
      formType: FormType.dualText,
      hasAdditionalInfo: false,
      title: "Boy ve kilonu gir",
      fieldKey: "height",
      fieldKey2: "weight",
      hint: "Boy",
      hint2: "Kilo",
      unit: "cm",
      unit2: "kg",
      inputType: TextInputType.number,
    ),
    // 7 — Aktivite seviyesi
    FormPagesModel(
      formType: FormType.choice,
      hasAdditionalInfo: true,
      title: "Aktivite seviyeni seç",
      fieldKey: "activityLevel",
      additionalInfoTitle: "Aktivite seviyesi nedir?",
      additionalInfoDescription:
          "Aktivite seviyeniz, günlük kalori ihtiyacınızı hesaplamak için kullanılır.\n\n"
          "• Hareketsiz: Masa başı iş, az hareket\n"
          "• Az Aktif: Haftada 1-3 gün hafif egzersiz\n"
          "• Orta Aktif: Haftada 3-5 gün orta egzersiz\n"
          "• Çok Aktif: Haftada 6-7 gün yoğun egzersiz",
      choices: ["Hareketsiz", "Az Aktif", "Orta Aktif", "Çok Aktif"],
    ),
    // 8 — Alerjenler (isteğe bağlı)
    FormPagesModel(
      formType: FormType.multiChoice,
      hasAdditionalInfo: false,
      title: "Herhangi bir alerjin var mı?",
      fieldKey: "allergies",
      isRequired: false,
      choices: [
        "Gluten",
        "Süt/Laktoz",
        "Yumurta",
        "Kuruyemiş",
        "Soya",
        "Balık",
        "Deniz Ürünleri",
        "Fıstık",
      ],
    ),
    // 9 — Sağlık durumları (isteğe bağlı)
    FormPagesModel(
      formType: FormType.multiChoice,
      hasAdditionalInfo: false,
      title: "Herhangi bir sağlık durumun var mı?",
      fieldKey: "healthConditions",
      isRequired: false,
      choices: [
        "Diyabet",
        "Hipertansiyon",
        "Kalp Hastalığı",
        "Çölyak",
        "Yüksek Kolesterol",
        "Obezite",
      ],
    ),
  ];
}
