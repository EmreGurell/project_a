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
                  const StatsCardsRow(
                    scrollable: false,
                    cards: [
                      StatCard(
                        title: 'BMI',
                        value: '22.4',
                        subtitle: '-1.2%',
                        icon: Icons.monitor_weight,
                        subtitleColor: Color.fromARGB(255, 37, 155, 76),
                      ),
                      StatCard(
                        title: 'STREAK',
                        value: '14',
                        subtitle: 'Days',
                        icon: Icons.local_fire_department,
                        subtitleColor: Colors.grey,
                      ),
                      StatCard(
                        title: 'CALS',
                        value: '2400',
                        icon: Icons.flag,
                        progress: 0.75,
                      ),
                    ],
                  ),
                  const SizedBox(height: ProjectSizes.spaceBtwSections),
                  ProfileBodyCard(
                    title: 'Vücut Bilgileri',
                    items: [
                      const BodyItem(
                        icon: Icons.height,
                        title: 'Boy',
                        value: '175 cm',
                        bgColor: ProjectColors.mainCardBlue,
                      ),
                      const BodyItem(
                        icon: Icons.monitor_weight,
                        title: 'Kilo',
                        value: '68 kg',
                        bgColor: ProjectColors.purple,
                      ),
                      BodyItem(
                        icon: Icons.cake,
                        title: 'Yaş',
                        value: 'Belirtilmemiş',
                        bgColor: ProjectColors.orange,
                      ),
                      BodyItem(
                        icon: Icons.person_outline,
                        title: 'Cinsiyet',
                        value: 'Diğer',
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
}