import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/core/errors/error_mapper.dart';
import 'package:project_a/main.dart';
import 'package:project_a/presentation/bloc/home/home_bloc.dart';
import 'package:project_a/presentation/bloc/home/home_event.dart';
import 'package:project_a/presentation/bloc/home/home_state.dart';
import 'package:project_a/presentation/widgets/home/calorie_summary_card.dart';
import 'package:project_a/presentation/widgets/home/water_intake_card.dart';
import 'package:project_a/presentation/widgets/home/date_picker.dart';
import 'package:project_a/presentation/widgets/home/header.dart';
import 'package:project_a/presentation/widgets/home/health_stats_row.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/utils/constants/sizes.dart';
import '../../../shared/widgets/buttons/headline.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    nutritionLoggedNotifier.addListener(_onNutritionLogged);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    nutritionLoggedNotifier.removeListener(_onNutritionLogged);
    super.dispose();
  }

  void _onNutritionLogged() {
    context.read<HomeBloc>().add(ChangeDate(DateTime.now()));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final blocState = context.read<HomeBloc>().state;
      if (blocState is HomeError) {
        context.read<HomeBloc>().add(LoadCurrentUser());
      }
    }
  }

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
            return _HomeErrorView(errorCode: state.message);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _HomeErrorView extends StatelessWidget {
  final String errorCode;
  const _HomeErrorView({required this.errorCode});

  @override
  Widget build(BuildContext context) {
    final message = ErrorMapper.getErrorMessage(context, errorCode);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ProjectSizes.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 48,
              color: ProjectColors.gray,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => context.read<HomeBloc>().add(LoadCurrentUser()),
              child: Text(AppLocalizations.of(context)!.home_retry),
            ),
          ],
        ),
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
            return Header(
              displayName: "${state.user.firstName} ${state.user.lastName}",
            );
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
              child: Builder(
                builder: (context) {
                  final l10n = AppLocalizations.of(context)!;
                  return Headline(
                    title: l10n.home_daily_summary,
                    subtitle: l10n.home_details,
                    icon: Icons.arrow_forward_ios,
                    onTap: () {},
                  );
                },
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
            Padding(
              padding: const EdgeInsets.only(right: ProjectSizes.pagePadding),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  final glasses = state is HomeLoaded ? state.waterGlasses : 0;
                  return WaterIntakeCard(currentGlasses: glasses);
                },
              ),
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
            Headline(
              title: AppLocalizations.of(context)!.home_health_data,
              onTap: () {},
            ),
            const SizedBox(height: 12),
            const HealthStatsRow(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
