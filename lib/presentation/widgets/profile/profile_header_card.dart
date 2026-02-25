import 'package:flutter/material.dart';
import 'package:project_a/shared/widgets/rounded_image/rounded_image.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

/// Profil fotoğrafı, isim ve Health Score gösteren kart (yeşil çerçeve + PRO badge).
class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.healthScore,
    this.showProBadge = false,
  });

  final String imageUrl;
  final String name;
  final int healthScore;
  final bool showProBadge;

  static const double _avatarSize = 124.0;
  static const double _borderWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: _avatarSize + _borderWidth * 2,
              height: _avatarSize + _borderWidth * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ProjectColors.leaderboardGreen.withValues(
                      alpha: 0.4,
                    ),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(
                  color: const Color.fromARGB(255, 56, 206, 56),
                  width: _borderWidth,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(_borderWidth),
                child: ClipOval(
                  child: RoundedImage(
                    imageUrl: imageUrl,
                    width: _avatarSize,
                    height: _avatarSize,
                    borderRadius: BorderRadius.circular(_avatarSize / 2),
                  ),
                ),
              ),
            ),
            if (showProBadge)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ProjectSizes.paddingSm,
                    vertical: ProjectSizes.paddingSm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Color.fromARGB(255, 111, 148, 24),
                    size: ProjectSizes.iconM,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: ProjectSizes.paddingMd),
        Text(
          name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: ProjectSizes.paddingSm),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: ProjectSizes.paddingLg,
            vertical: ProjectSizes.paddingSm,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Color.fromARGB(255, 122, 163, 27),
                size: ProjectSizes.iconM,
              ),
              const SizedBox(width: ProjectSizes.paddingSm),
              Text(
                'Health Score: $healthScore/100',
                style: const TextStyle(
                  color: Color.fromARGB(255, 169, 219, 50),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
