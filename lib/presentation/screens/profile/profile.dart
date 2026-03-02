import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_a/common/bloc/auth/auth_state_cubit.dart';
import 'package:project_a/presentation/bloc/profile/profile_bloc.dart';
import 'package:project_a/presentation/bloc/profile/profile_state.dart';
import 'package:project_a/core/router/route_names.dart';
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
          title: 'Profil',
          rightIcon: Icons.settings_outlined,
          onRightTap: () {},
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileFailure) {
              return Center(child: Text('Hata: ${state.message}'));
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
                        subtitle: 'Days',
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
                    title: 'Vücut Bilgileri',
                    items: [
                      BodyItem(
                        icon: Icons.height,
                        title: 'Boy',
                        value: metrics != null && metrics.height > 0
                            ? '${metrics.height.toInt()} cm'
                            : 'Belirtilmemiş',
                        bgColor: ProjectColors.mainCardBlue,
                      ),
                      BodyItem(
                        icon: Icons.monitor_weight,
                        title: 'Kilo',
                        value: metrics != null && metrics.weight > 0
                            ? '${metrics.weight.toInt()} kg'
                            : 'Belirtilmemiş',
                        bgColor: ProjectColors.purple,
                      ),
                      BodyItem(
                        icon: Icons.cake,
                        title: 'Yaş',
                        value: metrics?.age != null
                            ? '${metrics!.age} yaş'
                            : 'Belirtilmemiş',
                        bgColor: ProjectColors.orange,
                      ),
                      BodyItem(
                        icon: Icons.person_outline,
                        title: 'Cinsiyet',
                        value: _mapGenderDisplay(metrics?.gender),
                        bgColor: ProjectColors.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: ProjectSizes.spaceBtwSections),
                  ProfileSettingsCard(
                    items: [
                      SettingsToggleItem(
                        icon: Icons.notifications_outlined,
                        title: 'Bildirimler',
                        value: true,
                        onChanged: (value) {},
                      ),
                      SettingsNavItem(
                        icon: Icons.sync,
                        title: 'Sağlık Verilerini Senkronize Et',
                        onTap: () {},
                      ),
                      SettingsActionItem(
                        icon: Icons.logout,
                        title: 'Çıkış Yap',
                        onTap: () {
                          context.read<AuthStateCubit>().logout();
                        },
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

  String _mapGenderDisplay(String? gender) {
    switch (gender) {
      case 'male':
        return 'Erkek';
      case 'female':
        return 'Kadın';
      case 'other':
        return 'Diğer';
      default:
        return 'Belirtilmemiş';
    }
  }
}
