import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class CimbilChatBubble extends StatelessWidget {
  const CimbilChatBubble({super.key, required this.text, required this.isUser});
  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: ProjectSizes.paddingSm),
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.paddingMd,
          vertical: ProjectSizes.paddingSm,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? ProjectColors.orange : ProjectColors.cardGray,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(
              isUser
                  ? ProjectSizes.borderRadiusLg
                  : ProjectSizes.borderRadiusSm,
            ),
            bottomRight: Radius.circular(
              isUser
                  ? ProjectSizes.borderRadiusSm
                  : ProjectSizes.borderRadiusLg,
            ),
          ),
        ),
        child: Text(
          text,
          style: textTheme.bodyMedium?.copyWith(
            color: isUser ? Colors.white : Colors.black87,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
