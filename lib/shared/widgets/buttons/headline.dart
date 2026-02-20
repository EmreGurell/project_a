import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/sizes.dart';

class Headline extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback onTap;
  const Headline({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                ),
              const SizedBox(width: 4),
              if (icon != null)
                Icon(icon!, size: ProjectSizes.iconM, color: Colors.black),
            ],
          ),
        ),
      ],
    );
  }
}
