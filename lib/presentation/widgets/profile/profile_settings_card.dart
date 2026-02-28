import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class ProfileSettingsCard extends StatelessWidget {
  const ProfileSettingsCard({
    super.key,
    required this.items,
    this.title = 'Settings',
  });

  final String title;
  final List<SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: ProjectSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
            color: ProjectColors.cardGray,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: List.generate(items.length, (index) {
              return Column(
                children: [
                  items[index],
                  if (index != items.length - 1)
                    Divider(
                      height: 1,
                      indent: ProjectSizes.paddingLg,
                      endIndent: ProjectSizes.paddingLg,
                      color: Colors.grey.shade200,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

abstract class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key});
}

class SettingsToggleItem extends SettingsItem {
  const SettingsToggleItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ProjectSizes.paddingLg,
        vertical: ProjectSizes.paddingMd,
      ),
      child: Row(
        children: [
          _SettingsIcon(icon: icon),
          const SizedBox(width: ProjectSizes.paddingMd),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          SizedBox(
            height: 24,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: ProjectColors.green,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsNavItem extends SettingsItem {
  const SettingsNavItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.paddingLg,
          vertical: ProjectSizes.paddingMd,
        ),
        child: Row(
          children: [
            _SettingsIcon(icon: icon),
            const SizedBox(width: ProjectSizes.paddingMd),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsActionItem extends SettingsItem {
  const SettingsActionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor = Colors.red,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.paddingLg,
          vertical: ProjectSizes.paddingMd,
        ),
        child: Row(
          children: [
            _SettingsIcon(icon: icon),
            const SizedBox(width: ProjectSizes.paddingMd),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsIcon extends StatelessWidget {
  const _SettingsIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: Colors.black54),
    );
  }
}