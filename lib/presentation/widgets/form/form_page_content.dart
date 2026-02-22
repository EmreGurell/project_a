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

  const FormPageContent({super.key, required this.page});

  @override
  State<FormPageContent> createState() => _FormPageContentState();
}

class _FormPageContentState extends State<FormPageContent> {
  String? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(ProjectSizes.pagePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Title
            Text(
              widget.page.title,
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ProjectSizes.spaceBtwSections),
            //Image
            widget.page.image.isNotEmpty &&
                    widget.page.formType == FormType.image
                ? Image.asset(
                    widget.page.image,
                    height: DeviceUtility.getScreenWidth(context) * 1.2,
                    fit: BoxFit.contain,
                  )
                : SizedBox.shrink(),
            widget.page.image.isNotEmpty &&
                    widget.page.formType == FormType.animation
                ? Lottie.asset(
                    widget.page.image,
                    height: DeviceUtility.getScreenWidth(context) * 1.2,
                    fit: BoxFit.contain,
                  )
                : SizedBox.shrink(),
            widget.page.formType == FormType.text
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ProjectSizes.pagePadding,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height:
                              DeviceUtility.getScreenHeight(context) *
                              ProjectSizes.formTextFieldHeightFraction,
                        ),
                        TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: ProjectTexts.formAnswerHint,
                            hintStyle: Theme.of(context).textTheme.title!
                                .copyWith(
                                  fontSize: 20,
                                  color: ProjectColors.textGray,
                                ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 10,
                                color: ProjectColors.gray,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ProjectColors.gray,
                                width: 3,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ProjectColors.orange,
                                width: 4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            widget.page.formType == FormType.choice &&
                    widget.page.choices != null &&
                    widget.page.choices!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ProjectSizes.pagePadding,
                      vertical: ProjectSizes.pagePadding,
                    ),
                    child: _buildChoiceButtons(widget.page.choices!),
                  )
                : Spacer(),
            Spacer(),
            widget.page.hasAdditionalInfo
                ? TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        builder: (ctx) => Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(ctx).viewInsets.bottom,
                          ),
                          child: AdditionalInfoSheet(
                            title:
                                widget.page.additionalInfoTitle ??
                                ProjectTexts.formInfoTitle,
                            description:
                                widget.page.additionalInfoDescription ?? '',
                          ),
                        ),
                      );
                    },
                    icon: PhosphorIcon(
                      PhosphorIconsFill.info,
                      color: Colors.black,
                    ),
                    label: Text(
                      ProjectTexts.formWhyQuestion,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  )
                : Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceButtons(List<String> choices) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...choices.map(
          (choice) => Padding(
            padding: const EdgeInsets.symmetric(
              vertical: ProjectSizes.spaceBtwItems / 2,
            ),
            child: AnswerChoiceButton(
              text: choice,
              isSelected: _selectedChoice == choice,
              onPressed: () {
                setState(() {
                  _selectedChoice = choice;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
