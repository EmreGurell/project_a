import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/sizes.dart';

class ShadowedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? minLines;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputDecoration? decoration;
  final double shadowBlur;
  final Offset shadowOffset;
  final Color shadowColor;

  const ShadowedTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.decoration,
    this.shadowBlur = 2.0,
    this.shadowOffset = const Offset(0, 2),
    this.shadowColor = const Color(0x1A000000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusMd),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: shadowBlur,
            offset: shadowOffset,
          ),
        ],
      ),
      child: TextField(
        style: Theme.of(context).textTheme.labelSmall,
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration:
            decoration ??
            InputDecoration(
              labelText: labelText,
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
      ),
    );
  }
}
