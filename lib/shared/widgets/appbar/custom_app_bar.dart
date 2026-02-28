import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

/// Sol tarafta sayfa ismi (bold), sağ tarafta isteğe bağlı olarak
/// ya [rightLabel] (text) ya da [rightIcon] (badge ile veya tek icon).
/// İkisi birden verilmemeli.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.rightLabel,
    this.rightIcon,
    this.badgeCount,
    this.onRightTap,
    this.backgroundColor,
    this.iconSize,
  }) : assert(rightLabel == null || rightIcon == null);

  final String title;
  final String? rightLabel;
  final IconData? rightIcon;
  final int? badgeCount;
  final VoidCallback? onRightTap;

  final Color? backgroundColor;
  final double? iconSize;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? ProjectColors.white;

    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: bgColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      centerTitle: false,
      titleSpacing: ProjectSizes.pagePadding,
      title: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        if (rightLabel != null) _buildRightText(context, theme),
        if (rightIcon != null) _buildRightIcon(context),
      ],
    );
  }

  Widget _buildRightText(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ProjectSizes.pagePadding),
      child: Center(
        child: GestureDetector(
          onTap: onRightTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: ProjectSizes.paddingSm,
              vertical: ProjectSizes.paddingSm,
            ),
            child: Text(
              rightLabel!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRightIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ProjectSizes.pagePadding),
      child: Center(
        child: GestureDetector(
          onTap: onRightTap,
          behavior: HitTestBehavior.opaque,
          child: badgeCount != null && badgeCount! > 0
              ? Badge(
            label: Text(
              badgeCount! > 99 ? '99+' : '$badgeCount',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Icon(
              rightIcon,
              color: Colors.black,
              size: iconSize ?? ProjectSizes.iconL,
            ),
          )
              : Padding(
            padding: const EdgeInsets.all(ProjectSizes.paddingSm),
            child: Icon(
              rightIcon,
              color: Colors.black,
              size: iconSize ?? ProjectSizes.iconL,
            ),
          ),
        ),
      ),
    );
  }
}