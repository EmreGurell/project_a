import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_a/presentation/widgets/form/additional_info_sheet.dart';
import 'package:project_a/presentation/widgets/form/answer_choice_button.dart';
import 'package:project_a/data/models/form/form_pages_model.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/constants/texts.dart';

import 'package:project_a/utils/device/device_utility.dart';
import 'package:project_a/utils/themes/custom_themes/text_theme.dart';

class FormPageContent extends StatefulWidget {
  final FormPagesModel page;
  final String? currentAnswer;
  final String? currentAnswer2;
  final void Function(String key, String value)? onAnswerChanged;

  const FormPageContent({
    super.key,
    required this.page,
    this.currentAnswer,
    this.currentAnswer2,
    this.onAnswerChanged,
  });

  @override
  State<FormPageContent> createState() => _FormPageContentState();
}

class _FormPageContentState extends State<FormPageContent> {
  String? _selectedChoice;
  Set<String> _selectedChips = {};
  late final TextEditingController _controller;
  late final TextEditingController _controller2;

  @override
  void initState() {
    super.initState();
    _selectedChoice = widget.currentAnswer;
    _selectedChips = _parseChips(widget.currentAnswer);
    _controller = TextEditingController(text: widget.currentAnswer ?? '');
    _controller2 = TextEditingController(text: widget.currentAnswer2 ?? '');
  }

  Set<String> _parseChips(String? value) {
    if (value == null || value.isEmpty) return {};
    return value.split(',').toSet();
  }

  @override
  void didUpdateWidget(FormPageContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentAnswer != widget.currentAnswer) {
      _selectedChoice = widget.currentAnswer;
      _selectedChips = _parseChips(widget.currentAnswer);
      if (widget.page.formType == FormType.text) {
        _controller.text = widget.currentAnswer ?? '';
      }
    }
    if (oldWidget.currentAnswer2 != widget.currentAnswer2 &&
        widget.page.formType == FormType.dualText) {
      _controller2.text = widget.currentAnswer2 ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _notifyChange(String value) {
    final key = widget.page.fieldKey;
    if (key != null && widget.onAnswerChanged != null) {
      widget.onAnswerChanged!(key, value);
    }
  }

  void _notifyChange2(String value) {
    final key = widget.page.fieldKey2;
    if (key != null && widget.onAnswerChanged != null) {
      widget.onAnswerChanged!(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(ProjectSizes.pagePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.page.title,
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ProjectSizes.spaceBtwSections),
            // Image
            if (widget.page.image.isNotEmpty && widget.page.formType == FormType.image)
              Image.asset(
                widget.page.image,
                height: DeviceUtility.getScreenWidth(context) * 1.2,
                fit: BoxFit.contain,
              )
            else if (widget.page.image.isNotEmpty && widget.page.formType == FormType.animation)
              Lottie.asset(
                widget.page.image,
                height: DeviceUtility.getScreenWidth(context) * 1.2,
                fit: BoxFit.contain,
              ),
            // Text input
            if (widget.page.formType == FormType.text)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: ProjectSizes.pagePadding),
                child: Column(
                  children: [
                    SizedBox(
                      height: DeviceUtility.getScreenHeight(context) *
                          ProjectSizes.formTextFieldHeightFraction,
                    ),
                    _buildTextField(
                      controller: _controller,
                      hint: widget.page.hint ?? ProjectTexts.formAnswerHint,
                      unit: widget.page.unit,
                      inputType: widget.page.inputType,
                      onChanged: _notifyChange,
                    ),
                  ],
                ),
              ),
            // Dual text inputs
            if (widget.page.formType == FormType.dualText)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: ProjectSizes.pagePadding),
                child: Column(
                  children: [
                    SizedBox(
                      height: DeviceUtility.getScreenHeight(context) *
                          ProjectSizes.formTextFieldHeightFraction,
                    ),
                    _buildTextField(
                      controller: _controller,
                      hint: widget.page.hint ?? ProjectTexts.formAnswerHint,
                      unit: widget.page.unit,
                      inputType: widget.page.inputType,
                      onChanged: _notifyChange,
                    ),
                    const SizedBox(height: ProjectSizes.spaceBtwItems),
                    _buildTextField(
                      controller: _controller2,
                      hint: widget.page.hint2 ?? ProjectTexts.formAnswerHint,
                      unit: widget.page.unit2,
                      inputType: widget.page.inputType,
                      onChanged: _notifyChange2,
                    ),
                  ],
                ),
              ),
            // Choice buttons
            if (widget.page.formType == FormType.choice &&
                widget.page.choices != null &&
                widget.page.choices!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: ProjectSizes.pagePadding,
                  vertical: ProjectSizes.pagePadding,
                ),
                child: _buildChoiceButtons(widget.page.choices!),
              )
            // Multi-choice chips
            else if (widget.page.formType == FormType.multiChoice &&
                widget.page.choices != null &&
                widget.page.choices!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: ProjectSizes.pagePadding,
                  vertical: ProjectSizes.pagePadding,
                ),
                child: _buildMultiChoiceChips(widget.page.choices!),
              )
            else if (widget.page.formType != FormType.text &&
                widget.page.formType != FormType.dualText)
              const Spacer(),
            const Spacer(),
            if (widget.page.hasAdditionalInfo)
              TextButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (ctx) => Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
                      child: AdditionalInfoSheet(
                        title: widget.page.additionalInfoTitle ?? ProjectTexts.formInfoTitle,
                        description: widget.page.additionalInfoDescription ?? '',
                      ),
                    ),
                  );
                },
                icon: PhosphorIcon(PhosphorIconsFill.info, color: Colors.black),
                label: Text(
                  ProjectTexts.formWhyQuestion,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              )
            else
              const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    String? unit,
    TextInputType? inputType,
    required void Function(String) onChanged,
  }) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: inputType ?? TextInputType.text,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.title!.copyWith(
              fontSize: 20,
              color: ProjectColors.textGray,
            ),
        suffixText: unit,
        suffixStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ProjectColors.textGray,
            ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(width: 10, color: ProjectColors.gray),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.gray, width: 3),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.orange, width: 4),
        ),
      ),
    );
  }

  Widget _buildChoiceButtons(List<String> choices) {
    final values = widget.page.choiceValues;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...choices.indexed.map(
          ((int, String) entry) {
            final (i, choice) = entry;
            final apiValue = (values != null && i < values.length) ? values[i] : choice;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: ProjectSizes.spaceBtwItems / 2),
              child: AnswerChoiceButton(
                text: choice,
                isSelected: _selectedChoice == apiValue,
                onPressed: () {
                  setState(() => _selectedChoice = apiValue);
                  _notifyChange(apiValue);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMultiChoiceChips(List<String> choices) {
    final values = widget.page.choiceValues;
    return Wrap(
      spacing: ProjectSizes.spaceBtwItems,
      runSpacing: ProjectSizes.spaceBtwItems,
      children: choices.indexed.map(((int, String) entry) {
        final (i, choice) = entry;
        final apiValue = (values != null && i < values.length) ? values[i] : choice;
        final isSelected = _selectedChips.contains(apiValue);
        return FilterChip(
          label: Text(choice),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedChips.add(apiValue);
              } else {
                _selectedChips.remove(apiValue);
              }
            });
            _notifyChange(_selectedChips.join(','));
          },
          selectedColor: ProjectColors.orange.withOpacity(0.2),
          checkmarkColor: ProjectColors.orange,
          side: BorderSide(
            color: isSelected ? ProjectColors.orange : ProjectColors.gray,
          ),
        );
      }).toList(),
    );
  }
}
