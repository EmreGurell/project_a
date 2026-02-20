import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/common/bloc/button/button_state.dart';
import 'package:project_a/common/bloc/button/button_state_cubit.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class Button3D extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double? iconSize;

  const Button3D({
    super.key,
    required this.text,
    this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.iconSize,
  });

  @override
  State<Button3D> createState() => _Button3DState();
}

class _Button3DState extends State<Button3D> {
  bool _pressed = false;

  static const double _depth = 6.0;
  static const double _borderRadius = 16.0;
  static const Color shadowColor = Color(0xFFE68500);

  void _setPressed(bool value) {
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
      builder: (context, state) {
        if (state is ButtonLoadingState) {
          return _loading();
        }

        return _initial();
      },
    );
  }

  Widget _initial() {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) {
        _setPressed(false);
        widget.onPressed?.call();
      },
      onTapCancel: () => _setPressed(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _pressed ? _depth : 0, 0),
        decoration: BoxDecoration(
          color: ProjectColors.orange,
          borderRadius: BorderRadius.circular(_borderRadius),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: Offset(0, _pressed ? 0 : _depth),
              blurRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.leadingIcon != null) ...[
              Icon(
                widget.leadingIcon,
                color: Colors.white,
                size: widget.iconSize ?? 20,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              widget.text,
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(color: ProjectColors.white),
            ),
            if (widget.trailingIcon != null) ...[
              const SizedBox(width: 8),
              Icon(
                widget.trailingIcon,
                color: Colors.white,
                size: widget.iconSize ?? 20,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _loading() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 80),
      decoration: BoxDecoration(
        color: ProjectColors.orange,
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: const [
          BoxShadow(
            color: shadowColor,
            offset: Offset(0, _depth),
            blurRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: ProjectSizes.spaceBtwItems, horizontal: ProjectSizes.spaceBtwItems*2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.white,
            ),
          ),
          SizedBox(width: ProjectSizes.spaceBtwItems/2),
          Text(
            "Yükleniyor",
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(color: ProjectColors.white),
          ),
        ],
      ),
    );
  }
}
