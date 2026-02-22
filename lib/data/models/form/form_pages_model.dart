enum FormType { image, text, choice, animation }

class FormPagesModel {
  final String title;
  final List<String>? choices;
  final String image;
  final bool hasAdditionalInfo;
  final String? additionalInfoTitle;
  final String? additionalInfoDescription;
  final FormType formType;

  FormPagesModel({
    required this.title,
    this.choices,
    this.image = "",
    required this.hasAdditionalInfo,
    this.additionalInfoTitle,
    this.additionalInfoDescription,
    required this.formType,
  });
}
