import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/presentation/bloc/home/home_bloc.dart';
import 'package:project_a/presentation/bloc/home/home_event.dart';
import 'package:project_a/presentation/bloc/home/home_state.dart';
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
    return Scaffold(
      appBar: const _HomeAppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return const _HomeBody();
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
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
      systemOverlayStyle: const SystemUiOverlayStyle(
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
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return Header(displayName: "${state.user.firstName} ${state.user.lastName}");
          }
          return const Header();
        },
      ),
    );
  }
}

class _HomeScrollContent extends StatelessWidget {
  const _HomeScrollContent();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const _DatePickerSliver(),
        const _DailySummarySliver(),
        const _HealthStatsSliver(),
      ],
    );
  }
}

class _DatePickerSliver extends StatelessWidget {
  const _DatePickerSliver();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 24, bottom: 24),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              return DatePicker(
                state.dateRange.first,
                height: 84,
                width: 56,
                initialSelectedDate: state.selectedDate,
                selectedTextColor: Colors.white,
                onDateSelected: (date) =>
                    context.read<HomeBloc>().add(ChangeDate(date)),
              );
            }
            return const SizedBox(height: 84);
          },
        ),
      ),
    );
  }
}

class _DailySummarySliver extends StatelessWidget {
  const _DailySummarySliver({super.key});
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
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  if (state.isNutritionLoading) {
                    return const CalorieSummaryCard(isLoading: true);
                  }
                  return CalorieSummaryCard(nutrition: state.nutrition);
                }
                return const CalorieSummaryCard();
              },
            ),
            const SizedBox(height: ProjectSizes.spaceBtwItems),
            const Padding(
              padding: EdgeInsets.only(right: ProjectSizes.pagePadding),
              child: WaterIntakeCard(),
            ),
            const SizedBox(height: ProjectSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}

class _HealthStatsSliver extends StatelessWidget {
  const _HealthStatsSliver({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Headline(title: 'Sağlık Verileri', onTap: () {}),
            const SizedBox(height: 12),
            const HealthStatsRow(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}


