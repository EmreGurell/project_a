import 'package:flutter/material.dart';
import 'package:project_a/presentation/widgets/form/additional_info_sheet.dart';

void showAdditionalInfoModal(
  BuildContext context, {
  required String title,
  required String description,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: AdditionalInfoSheet(title: title, description: description),
    ),
  );
}
