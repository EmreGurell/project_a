import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';

class AnswerChoiceButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const AnswerChoiceButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  State<AnswerChoiceButton> createState() => _AnswerChoiceButtonState();
}

class _AnswerChoiceButtonState extends State<AnswerChoiceButton> {
  bool _pressed = false;

  static const double _depth = 6.0;
  static const double _borderRadius = 12.0;

  void _setPressed(bool value) {
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = widget.isSelected ? Colors.white : Colors.black;
    final Color buttonColor = widget.isSelected
        ? ProjectColors.choiceGreen
        : ProjectColors.white;
    final Color shadowColor = widget.isSelected
        ? ProjectColors.choiceDarkGreen
        : ProjectColors.gray;

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) {
        _setPressed(false);
        widget.onPressed();
      },
      onTapCancel: () => _setPressed(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _pressed ? _depth : 0, 0),
        decoration: BoxDecoration(
          border: Border.all(color: shadowColor),
          color: buttonColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: Offset(0, _pressed ? 0 : _depth),
              blurRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        child: Text(
          widget.text,
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
