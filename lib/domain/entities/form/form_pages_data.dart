import 'package:project_a/data/models/form/form_pages_model.dart';
import 'package:project_a/utils/constants/image_paths.dart';

class FormPagesData {
  FormPagesData._();

  static final List<FormPagesModel> pages = [
    FormPagesModel(
      formType: FormType.image,
      hasAdditionalInfo: false,
      title: "Önce bir kaç soruyla başlayalım!",
      image: ImageAndAnimationPaths.form1,
    ),
    FormPagesModel(
      formType: FormType.text,
      hasAdditionalInfo: false,
      title: "Sana nasıl hitap edeyim?",
    ),
    FormPagesModel(
      formType: FormType.choice,
      hasAdditionalInfo: true,
      title: "Ana hedefin ne?",
      choices: [
        "Kilo vermek",
        "Kilo almak",
        "Mevcut kiloyu korumak",
        "Kas Yapmak",
      ],
    ),
  ];
}
