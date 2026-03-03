import 'package:flutter/material.dart';
import 'package:project_a/data/models/form/form_pages_model.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/utils/constants/image_paths.dart';

class FormPagesData {
  FormPagesData._();

  static List<FormPagesModel> pages(AppLocalizations l10n) => [
    // 1 — Intro
    FormPagesModel(
      formType: FormType.image,
      hasAdditionalInfo: false,
      title: l10n.form_intro_title,
      image: ImageAndAnimationPaths.form1,
      isRequired: false,
    ),
    // 2 — Kullanıcı adı
    FormPagesModel(
      formType: FormType.text,
      hasAdditionalInfo: false,
      title: l10n.form_username_title,
      fieldKey: "username",
      hint: l10n.form_username_hint,
      inputType: TextInputType.text,
    ),
    // 3 — Hedef
    FormPagesModel(
      formType: FormType.choice,
      hasAdditionalInfo: false,
      title: l10n.form_goal_title,
      fieldKey: "goal",
      choices: [
        l10n.form_goal_lose_weight,
        l10n.form_goal_gain_weight,
        l10n.form_goal_maintain_weight,
        l10n.form_goal_build_muscle,
      ],
      choiceValues: const ['lose_weight', 'gain_weight', 'maintain', 'gain_muscle'],
    ),
    // 4 — Cinsiyet
    FormPagesModel(
      formType: FormType.choice,
      hasAdditionalInfo: false,
      title: l10n.form_gender_title,
      fieldKey: "gender",
      choices: [l10n.form_gender_male, l10n.form_gender_female, l10n.form_gender_other],
      choiceValues: const ['male', 'female', 'other'],
    ),
    // 5 — Yaş
    FormPagesModel(
      formType: FormType.text,
      hasAdditionalInfo: false,
      title: l10n.form_age_title,
      fieldKey: "age",
      hint: l10n.form_age_hint,
      unit: l10n.form_age_unit,
      inputType: TextInputType.number,
    ),
    // 6 — Boy + Kilo
    FormPagesModel(
      formType: FormType.dualText,
      hasAdditionalInfo: false,
      title: l10n.form_body_title,
      fieldKey: "height",
      fieldKey2: "weight",
      hint: l10n.form_height_hint,
      hint2: l10n.form_weight_hint,
      unit: l10n.form_height_unit,
      unit2: l10n.form_weight_unit,
      inputType: TextInputType.number,
    ),
    // 7 — Aktivite seviyesi
    FormPagesModel(
      formType: FormType.choice,
      hasAdditionalInfo: true,
      title: l10n.form_activity_title,
      fieldKey: "activityLevel",
      additionalInfoTitle: l10n.form_activity_info_title,
      additionalInfoDescription: l10n.form_activity_info_desc,
      choices: [
        l10n.form_activity_sedentary,
        l10n.form_activity_lightly_active,
        l10n.form_activity_moderately_active,
        l10n.form_activity_very_active,
      ],
      choiceValues: const ['sedentary', 'light', 'moderate', 'active'],
    ),
    // 8 — Alerjenler (isteğe bağlı)
    FormPagesModel(
      formType: FormType.multiChoice,
      hasAdditionalInfo: false,
      title: l10n.form_allergies_title,
      fieldKey: "allergies",
      isRequired: false,
      choices: [
        l10n.form_allergy_gluten,
        l10n.form_allergy_dairy,
        l10n.form_allergy_eggs,
        l10n.form_allergy_nuts,
        l10n.form_allergy_soy,
        l10n.form_allergy_fish,
        l10n.form_allergy_shellfish,
        l10n.form_allergy_peanuts,
      ],
      choiceValues: const ['gluten', 'dairy', 'eggs', 'tree_nuts', 'soy', 'fish', 'shellfish', 'peanuts'],
    ),
    // 9 — Sağlık durumları (isteğe bağlı)
    FormPagesModel(
      formType: FormType.multiChoice,
      hasAdditionalInfo: false,
      title: l10n.form_health_title,
      fieldKey: "healthConditions",
      isRequired: false,
      choices: [
        l10n.form_health_diabetes,
        l10n.form_health_hypertension,
        l10n.form_health_heart_disease,
        l10n.form_health_celiac,
        l10n.form_health_high_cholesterol,
        l10n.form_health_obesity,
      ],
      choiceValues: const ['diabetes', 'hypertension', 'heart_disease', 'celiac', 'high_cholesterol', 'obesity'],
    ),
  ];
}
