import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class BodyItem {
  const BodyItem({
    required this.icon,
    required this.title,
    required this.value,
    this.bgColor,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color? bgColor;
}

class ProfileBodyCard extends StatelessWidget {
  const ProfileBodyCard({
    super.key,
    this.title = 'My Body',
    required this.items,
  });

  final String title;
  final List<BodyItem> items;

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
              final item = items[index];
              return Column(
                children: [
                  _BodyRow(item: item),
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

class _BodyRow extends StatelessWidget {
  const _BodyRow({required this.item});

  final BodyItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ProjectSizes.paddingLg,
        vertical: ProjectSizes.paddingMd,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: item.bgColor ?? ProjectColors.secondaryCardBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(item.icon, size: 18, color: Colors.white),
          ),
          const SizedBox(width: ProjectSizes.paddingMd),
          Expanded(
            child: Text(
              item.title,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Text(
            item.value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}