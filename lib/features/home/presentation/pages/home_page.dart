import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_a/common/widgets/buttons/headline.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/features/home/presentation/widget/calorie_summary_card.dart';
import 'package:project_a/features/home/presentation/widget/date_picker.dart';
import 'package:project_a/features/home/presentation/widget/header.dart';
import 'package:project_a/features/home/presentation/widget/health_stats_row.dart';
import 'package:project_a/features/home/presentation/widget/water_intake_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
            child: Header(),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 24),
                    child: DatePicker(
                      DateTime.now(),
                      height: 100,
                      width: 72,
                      initialSelectedDate: DateTime.now(),
                      selectedTextColor: Colors.white,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Headline(
                      title: 'Günlük Özet',
                      subtitle: 'Detaylar',
                      icon: Icons.arrow_forward_ios,
                      onTap: () {},
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      right: 24,
                      bottom: 12,
                    ),
                    child: CalorieSummaryCard(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      right: 64,
                      bottom: 24,
                    ),
                    child: WaterIntakeCard(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      left: 24,
                      right: 24,
                      bottom: 24,
                    ),
                    child: HealthStatsRow(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: ProjectColors.orange,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
