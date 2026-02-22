import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_a/core/router/route_names.dart';
import 'package:project_a/presentation/widgets/home/calorie_summary_card.dart';
import 'package:project_a/presentation/widgets/home/water_intake_card.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/presentation/widgets/home/date_picker.dart';
import 'package:project_a/presentation/widgets/home/header.dart';
import 'package:project_a/presentation/widgets/home/health_stats_row.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/device/device_utility.dart';

import '../../../shared/widgets/buttons/headline.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _HomeAppBar(),
      body: const _HomeBody(),
      bottomNavigationBar: const HomeBottomNavigation(),
    );
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _HomeHeaderSection(),
        SizedBox(height: 24),
        Expanded(child: _HomeScrollContent()),
      ],
    );
  }
}

class _HomeHeaderSection extends StatelessWidget {
  const _HomeHeaderSection();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24),
      child: Header(),
    );
  }
}

class _HomeScrollContent extends StatelessWidget {
  const _HomeScrollContent();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _DatePickerSliver(),
        _DailySummarySliver(),
        _HealthStatsSliver(),
      ],
    );
  }
}

class _DailySummarySliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: ProjectSizes.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: ProjectSizes.pagePadding),
              child: Headline(
                title: 'Günlük Özet',
                subtitle: 'Detaylar',
                icon: Icons.arrow_forward_ios,
                onTap: () {},
              ),
            ),
            const SizedBox(height: ProjectSizes.spaceBtwItems),
            const CalorieSummaryCard(),
            const SizedBox(height: ProjectSizes.spaceBtwItems),
            Padding(
              padding: const EdgeInsets.only(right: ProjectSizes.pagePadding),
              child: const WaterIntakeCard(),
            ),
            const SizedBox(height: ProjectSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}

class _DatePickerSliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 24),
        child: DatePicker(
          DateTime.now(),
          height: 84,
          width: 56,
          initialSelectedDate: DateTime.now(),
          selectedTextColor: Colors.white,
        ),
      ),
    );
  }
}

class _HealthStatsSliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Headline(title: 'Sağlık Verileri', onTap: () {}),
            SizedBox(height: 12),
            HealthStatsRow(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceUtility.getBottomNavigationBarHeight() * 2 + 32,
      child: const Stack(
        alignment: Alignment.topCenter,
        children: [_AIAssistantBar(), _MainBottomBar()],
      ),
    );
  }
}

class _AIAssistantBar extends StatelessWidget {
  const _AIAssistantBar();

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
                  onTap: () {},
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
  const _MainBottomBar();

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
            IconButton(
              onPressed: () {},
              icon: const PhosphorIcon(PhosphorIconsRegular.carrot),
            ),
            IconButton(
              onPressed: () {},
              icon: const PhosphorIcon(PhosphorIconsRegular.bookOpenText),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: EdgeInsets.all(ProjectSizes.paddingMd / 1.25),
                elevation: 0,
                backgroundColor: ProjectColors.mainCardBlue,
              ),
              onPressed: () {},
              child: const PhosphorIcon(
                PhosphorIconsRegular.plus,
                color: ProjectColors.white,
                size: ProjectSizes.iconL,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const PhosphorIcon(PhosphorIconsRegular.usersThree),
            ),
            IconButton(
              onPressed: () => context.go(RouteNames.profileRoute),
              icon: const PhosphorIcon(PhosphorIconsRegular.userCircle),
            ),
          ],
        ),
      ),
    );
  }
}
