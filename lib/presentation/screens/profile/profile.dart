import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_a/common/bloc/auth/auth_state_cubit.dart';
import 'package:project_a/presentation/bloc/profile/profile_bloc.dart';
import 'package:project_a/presentation/bloc/profile/profile_state.dart';
import 'package:project_a/core/router/route_names.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/shared/widgets/appbar/custom_app_bar.dart';
import 'package:project_a/presentation/widgets/profile/profile_header_card.dart';
import 'package:project_a/presentation/widgets/profile/stats_cards_row.dart';
import 'package:project_a/presentation/widgets/profile/stat_card.dart';
import 'package:project_a/presentation/widgets/profile/profile_body_card.dart';
import 'package:project_a/presentation/widgets/profile/profile_settings_card.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

import '../../../common/bloc/auth/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthStateCubit, AuthState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              context.go(RouteNames.loginRoute);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          title: l10n.profile_title,
          rightIcon: Icons.settings_outlined,
          onRightTap: () {},
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileFailure) {
              return Center(child: Text('${l10n.profile_error_prefix}: ${state.message}'));
            }

            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileLoaded) {
              final user = state.user;
              final metrics = state.metrics;
              return ListView(
                padding: const EdgeInsets.all(ProjectSizes.pagePadding),
                children: [
                  ProfileHeaderCard(
                    imageUrl: 'https://i.pravatar.cc/200?img=1',
                    name: "${user.firstName} ${user.lastName}",
                    healthScore: 92,
                    showProBadge: true,
                  ),
                  const SizedBox(height: ProjectSizes.spaceBtwSections),
                  StatsCardsRow(
                    scrollable: false,
                    cards: [
                      StatCard(
                        title: 'BMI',
                        value: metrics != null && metrics.bmi > 0
                            ? metrics.bmi.toStringAsFixed(1)
                            : '--',
                        icon: Icons.monitor_weight,
                      ),
                      StatCard(
                        title: 'STREAK',
                        value: metrics != null ? '${metrics.currentStreak}' : '--',
                        subtitle: l10n.profile_streak_days,
                        icon: Icons.local_fire_department,
                        subtitleColor: Colors.grey,
                      ),
                      StatCard(
                        title: 'CALS',
                        value: metrics != null && metrics.dailyCalorieGoal > 0
                            ? metrics.dailyCalorieGoal.toInt().toString()
                            : '--',
                        icon: Icons.flag,
                        progress: 0,
                      ),
                    ],
                  ),
                  const SizedBox(height: ProjectSizes.spaceBtwSections),
                  ProfileBodyCard(
                    title: l10n.profile_body_info_title,
                    items: [
                      BodyItem(
                        icon: Icons.height,
                        title: l10n.profile_height,
                        value: metrics != null && metrics.height > 0
                            ? '${metrics.height.toInt()} cm'
                            : l10n.profile_not_specified,
                        bgColor: ProjectColors.mainCardBlue,
                      ),
                      BodyItem(
                        icon: Icons.monitor_weight,
                        title: l10n.profile_weight,
                        value: metrics != null && metrics.weight > 0
                            ? '${metrics.weight.toInt()} kg'
                            : l10n.profile_not_specified,
                        bgColor: ProjectColors.purple,
                      ),
                      BodyItem(
                        icon: Icons.cake,
                        title: l10n.profile_age,
                        value: metrics?.age != null
                            ? '${metrics!.age} ${l10n.profile_age_unit}'
                            : l10n.profile_not_specified,
                        bgColor: ProjectColors.orange,
                      ),
                      BodyItem(
                        icon: Icons.person_outline,
                        title: l10n.profile_gender,
                        value: _mapGenderDisplay(l10n, metrics?.gender),
                        bgColor: ProjectColors.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: ProjectSizes.spaceBtwSections),
                  ProfileSettingsCard(
                    items: [
                      SettingsToggleItem(
                        icon: Icons.notifications_outlined,
                        title: l10n.profile_notifications,
                        value: true,
                        onChanged: (value) {},
                      ),
                      SettingsNavItem(
                        icon: Icons.sync,
                        title: l10n.profile_sync_health,
                        onTap: () {},
                      ),
                      SettingsActionItem(
                        icon: Icons.logout,
                        title: l10n.profile_logout,
                        onTap: () => _showLogoutDialog(context, l10n),
                      ),
                    ],
                  ),
                  const SizedBox(height: ProjectSizes.spaceBtwSections),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.profile_logout_confirm_title),
        content: Text(l10n.profile_logout_confirm_message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.profile_logout_cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AuthStateCubit>().logout();
            },
            child: Text(l10n.profile_logout_confirm),
          ),
        ],
      ),
    );
  }

  String _mapGenderDisplay(AppLocalizations l10n, String? gender) {
    switch (gender) {
      case 'male':
        return l10n.profile_gender_male;
      case 'female':
        return l10n.profile_gender_female;
      case 'other':
        return l10n.profile_gender_other;
      default:
        return l10n.profile_not_specified;
    }
  }
}
