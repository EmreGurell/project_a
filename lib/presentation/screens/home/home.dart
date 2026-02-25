import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_a/presentation/widgets/home/calorie_summary_card.dart';
import 'package:project_a/presentation/widgets/home/water_intake_card.dart';
import 'package:project_a/presentation/widgets/home/date_picker.dart';
import 'package:project_a/presentation/widgets/home/header.dart';
import 'package:project_a/presentation/widgets/home/health_stats_row.dart';
import 'package:project_a/utils/constants/sizes.dart';

import '../../../shared/widgets/buttons/headline.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const _HomeAppBar(), body: const _HomeBody());
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
