import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_a/common/bloc/user/user_bloc.dart';
import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/core/router/route_names.dart';
import 'package:project_a/shared/widgets/appbar/custom_app_bar.dart';

import 'package:project_a/presentation/widgets/profile/profile_header_card.dart';
import 'package:project_a/presentation/widgets/profile/stats_cards_row.dart';
import 'package:project_a/presentation/widgets/profile/stat_card.dart';
import 'package:project_a/presentation/widgets/profile/profile_body_card.dart';
import 'package:project_a/presentation/widgets/profile/profile_settings_card.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/local_storage/storage_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profil',
        rightIcon: Icons.settings_outlined,
        onRightTap: () {},
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          //Hata durumunda
          if (state is UserFailure) {
            return Center(child: Text('Hata: ${state.message}'));
          }

          //Yükleniyor durumunda
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          //Yüklenmiş veri durumunda
          if (state is UserLoaded) {
            return ListView(
              padding: const EdgeInsets.all(ProjectSizes.pagePadding),
              children: [
                ProfileHeaderCard(
                  imageUrl: 'https://i.pravatar.cc/200?img=1',
                  name: state.user.displayName,
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
                // My Body card (height, weight, age, gender)
                const ProfileBodyCard(
                  title: 'My Body',
                  items: [
                    BodyItem(
                      icon: Icons.height,
                      title: 'Height',
                      value: '175 cm',
                      bgColor: ProjectColors.mainCardBlue,
                    ),
                    BodyItem(
                      icon: Icons.monitor_weight,
                      title: 'Weight',
                      value: '68 kg',
                      bgColor: ProjectColors.purple,
                    ),
                    BodyItem(
                      icon: Icons.cake,
                      title: 'Age',
                      value: '28',
                      bgColor: ProjectColors.orange,
                    ),
                    BodyItem(
                      icon: Icons.female,
                      title: 'Gender',
                      value: 'Female',
                      bgColor: ProjectColors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: ProjectSizes.spaceBtwSections),
                ProfileSettingsCard(
                  items: [
                    SettingsToggleItem(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      value: true,
                      onChanged: (value) {},
                    ),
                    SettingsNavItem(
                      icon: Icons.sync,
                      title: 'Sync Health Data',
                      onTap: () {},
                    ),
                    SettingsActionItem(
                      icon: Icons.logout,
                      title: 'Log Out',
                      onTap: () async {
                        await sl<LocalStorageService>().clearToken();
                        if (!context.mounted) return;
                        context.read<UserBloc>().add(GetUserMeEvent());
                        context.go(RouteNames.loginRoute);
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
    );
  }
}
