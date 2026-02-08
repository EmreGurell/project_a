import 'package:flutter/material.dart';

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
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              const SizedBox(width: 4),
              if (icon != null) Icon(icon!, size: 16, color: Colors.black),
            ],
          ),
        ),
      ],
    );
  }
}
