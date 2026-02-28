import 'package:flutter/material.dart';

enum FormType { image, text, choice, animation, dualText }

class FormPagesModel {
  final String title;
  final List<String>? choices;
  final String image;
  final bool hasAdditionalInfo;
  final String? additionalInfoTitle;
  final String? additionalInfoDescription;
  final FormType formType;
  final String? fieldKey;
  final String? fieldKey2;
  final String? hint;
  final String? hint2;
  final String? unit;
  final String? unit2;
  final TextInputType? inputType;

  FormPagesModel({
    required this.title,
    this.choices,
    this.image = "",
    required this.hasAdditionalInfo,
    this.additionalInfoTitle,
    this.additionalInfoDescription,
    required this.formType,
    this.fieldKey,
    this.fieldKey2,
    this.hint,
    this.hint2,
    this.unit,
    this.unit2,
    this.inputType,
  });
}
