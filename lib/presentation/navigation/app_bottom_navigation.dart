import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/device/device_utility.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback? onAddTap;
  final VoidCallback? onAITap;

  const AppBottomNavigation({
    required this.currentIndex,
    required this.onTap,
    this.onAddTap,
    this.onAITap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceUtility.getBottomNavigationBarHeight() * 2 + 32,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          _AIAssistantBar(onTap: onAITap),
          _MainBottomBar(
            currentIndex: currentIndex,
            onTap: onTap,
            onAddTap: onAddTap,
          ),
        ],
      ),
    );
  }
}

class _AIAssistantBar extends StatelessWidget {
  final VoidCallback? onTap;
  const _AIAssistantBar({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          color: ProjectColors.orange,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ProjectSizes.imageAndCardRadius * 2),
            topRight: Radius.circular(ProjectSizes.imageAndCardRadius * 2),
          ),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: ProjectSizes.pagePadding / 1.3,
              horizontal: ProjectSizes.pagePadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Row(
                    children: [
                      PhosphorIcon(
                        PhosphorIconsRegular.robot,
                        color: ProjectColors.white,
                      ),
                      SizedBox(width: ProjectSizes.spaceBtwItems / 2),
                      Text(
                        "Cımbıl AI'a istediğini sor...",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: ProjectColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                PhosphorIcon(
                  PhosphorIconsRegular.microphone,
                  color: ProjectColors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MainBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback? onAddTap;

  const _MainBottomBar({
    required this.currentIndex,
    required this.onTap,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: ProjectColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ProjectSizes.imageAndCardRadius * 2),
            topRight: Radius.circular(ProjectSizes.imageAndCardRadius * 2),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.pagePadding,
          vertical: ProjectSizes.paddingMd,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavItem(
              icon: PhosphorIconsRegular.carrot,
              activeIcon: PhosphorIconsFill.carrot,
              isActive: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavItem(
              icon: PhosphorIconsRegular.bookOpenText,
              activeIcon: PhosphorIconsFill.bookOpenText,
              isActive: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: EdgeInsets.all(ProjectSizes.paddingMd / 1.25),
                elevation: 0,
                backgroundColor: ProjectColors.mainCardBlue,
              ),
              onPressed: onAddTap ?? () {},
              child: const PhosphorIcon(
                PhosphorIconsRegular.plus,
                color: ProjectColors.white,
                size: ProjectSizes.iconL,
              ),
            ),
            _NavItem(
              icon: PhosphorIconsRegular.usersThree,
              activeIcon: PhosphorIconsFill.usersThree,
              isActive: currentIndex == 2,
              onTap: () => onTap(2),
            ),
            _NavItem(
              icon: PhosphorIconsRegular.userCircle,
              activeIcon: PhosphorIconsFill.userCircle,
              isActive: currentIndex == 3,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: PhosphorIcon(
        isActive ? activeIcon : icon,
        color: isActive ? ProjectColors.orange : ProjectColors.textGray,
      ),
    );
  }
}