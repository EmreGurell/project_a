import 'package:flutter/material.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class CimbilInputBar extends StatelessWidget {
  const CimbilInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    this.isLoading = false,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.only(
        left: ProjectSizes.paddingMd,
        right: ProjectSizes.paddingSm,
        top: ProjectSizes.paddingMd,
        bottom: bottomPadding + ProjectSizes.paddingSm,
      ),
      decoration: BoxDecoration(
        color: ProjectColors.white,
        border: Border(
          top: BorderSide(color: ProjectColors.gray.withOpacity(0.4)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ProjectColors.cardGray,
                borderRadius: BorderRadius.circular(
                  ProjectSizes.authCardRadius,
                ),
              ),
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  hintText: l10n.cimbil_input_hint,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: ProjectColors.textGray.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: ProjectSizes.paddingMd,
                    vertical: ProjectSizes.paddingSm,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: ProjectSizes.paddingSm),
          GestureDetector(
            onTap: isLoading ? null : onSend,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: isLoading
                      ? [Colors.grey, Colors.grey.shade400]
                      : [ProjectColors.orange, const Color(0xFFFF6B6B)],
                ),
              ),
              child: isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(
                      Icons.arrow_upward_rounded,
                      color: Colors.white,
                      size: ProjectSizes.iconM,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
