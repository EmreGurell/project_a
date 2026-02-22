import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/themes/custom_themes/text_theme.dart';

class MealHeader extends StatelessWidget {
  final String? imageUrl;
  final String? imagePath;
  final String title;
  final int totalCalories;
  final bool isExpanded;
  final VoidCallback onTap;

  const MealHeader({
    super.key,
    this.imageUrl,
    this.imagePath,
    required this.title,
    required this.totalCalories,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            // Resim Alanı
            ClipRRect(
              borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusSm),
              child: Container(
                width: ProjectSizes.iconM,
                height: ProjectSizes.iconM,
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(
                    ProjectSizes.borderRadiusSm,
                  ),
                  border: Border.all(color: Colors.orange.shade100),
                ),
                child: _buildImage(),
              ),
            ),
            const SizedBox(width: 15),
            // Metin Alanı
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ProjectTextTheme.lightTextTheme.headlineLarge
                      ?.copyWith(),
                ),
                Text(
                  "$totalCalories Kalori",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ProjectColors.textGray,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Ok İkonu
            Icon(
              isExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_left,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: ProjectSizes.iconM,
        height: ProjectSizes.iconM,
        errorBuilder: (_, __, ___) => Center(
          child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
        ),
      );
    }
    if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.asset(
        imagePath!,
        fit: BoxFit.cover,
        width: ProjectSizes.iconM,
        height: ProjectSizes.iconM,
        errorBuilder: (_, __, ___) => Center(
          child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
        ),
      );
    }
    return Center(child: Icon(Icons.image, color: Colors.grey[400]));
  }
}
