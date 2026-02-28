import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/data/models/nutrition/ai_nutrition_result_model.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/presentation/bloc/nutrition/nutrition_result_bloc.dart';
import 'package:project_a/presentation/bloc/nutrition/nutrition_result_event.dart';
import 'package:project_a/presentation/bloc/nutrition/nutrition_result_state.dart';
import 'package:project_a/presentation/widgets/nutrition/nutrition_detail_card.dart';
import 'package:project_a/presentation/widgets/nutrition/nutrition_macro.dart';
import 'package:project_a/presentation/widgets/nutrition/nutrition_macro_circle.dart';
import 'package:project_a/presentation/widgets/nutrition/nutrition_photo_section.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class NutritionResultPage extends StatelessWidget {
  const NutritionResultPage({
    super.key,
    this.photoPath,
    this.barcode,
    required this.mode,
  });

  final String? photoPath;
  final String? barcode;
  final String mode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<NutritionResultBloc>();
        if (barcode != null) {
          bloc.add(AnalyzeBarcode(barcode!));
        } else if (photoPath != null) {
          bloc.add(AnalyzeImage(photoPath!));
        }
        return bloc;
      },
      child: _NutritionResultView(photoPath: photoPath, barcode: barcode, mode: mode),
    );
  }
}

class _NutritionResultView extends StatelessWidget {
  const _NutritionResultView({
    required this.photoPath,
    required this.barcode,
    required this.mode,
  });

  final String? photoPath;
  final String? barcode;
  final String mode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: ProjectColors.white,
      appBar: AppBar(
        backgroundColor: ProjectColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: ProjectSizes.iconM),
        ),
        centerTitle: true,
        title: Text(
          mode == 'barcode' ? l10n.nutrition_title_barcode : l10n.nutrition_title_food,
          style: textTheme.titleLarge?.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle_outline,
              color: ProjectColors.orange,
              size: ProjectSizes.iconL,
            ),
          ),
        ],
      ),
      body: BlocBuilder<NutritionResultBloc, NutritionResultState>(
        builder: (context, state) {
          if (state is NutritionResultLoading || state is NutritionResultInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NutritionResultError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(ProjectSizes.pagePadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: ProjectSizes.paddingMd),
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: ProjectSizes.paddingMd),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Geri dön'),
                    ),
                  ],
                ),
              ),
            );
          }

          final result = (state as NutritionResultLoaded).result;
          return _NutritionContent(
            result: result,
            photoPath: photoPath,
            barcode: barcode,
            mode: mode,
          );
        },
      ),
    );
  }
}

class _NutritionContent extends StatelessWidget {
  const _NutritionContent({
    required this.result,
    required this.photoPath,
    required this.barcode,
    required this.mode,
  });

  final AiNutritionResultModel result;
  final String? photoPath;
  final String? barcode;
  final String mode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    final macros = [
      NutritionMacro(
        name: l10n.nutrition_fat,
        grams: result.fat.round(),
        dailyTarget: 65,
        color: const Color(0xFFF9D56E),
      ),
      NutritionMacro(
        name: l10n.nutrition_protein,
        grams: result.protein.round(),
        dailyTarget: 50,
        color: const Color(0xFFFA8072),
      ),
      NutritionMacro(
        name: l10n.nutrition_carb,
        grams: result.carbs.round(),
        dailyTarget: 130,
        color: const Color(0xFF87CEEB),
      ),
      if (result.fiber != null)
        NutritionMacro(
          name: l10n.nutrition_fiber,
          grams: result.fiber!.round(),
          dailyTarget: 25,
          color: const Color(0xFFB5EAD7),
        ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: ProjectSizes.paddingSm),

          if (photoPath != null) NutritionPhotoSection(photoPath: photoPath!),

          if (barcode != null) ...[
            const SizedBox(height: ProjectSizes.paddingSm + 4),
            _BarcodeChip(barcode: barcode!),
          ],

          if (result.name.isNotEmpty) ...[
            const SizedBox(height: ProjectSizes.paddingMd),
            Text(
              result.name,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],

          const SizedBox(height: ProjectSizes.paddingLg),

          Text(
            '${result.calories.round()} ${l10n.nutrition_kcal_suffix}',
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: ProjectSizes.paddingSm),
          Text(
            mode == 'barcode'
                ? l10n.nutrition_portion_single
                : l10n.nutrition_portion_estimated,
            style: textTheme.bodySmall?.copyWith(color: ProjectColors.textGray),
          ),

          if (result.portionSize != null) ...[
            const SizedBox(height: 4),
            Text(
              result.portionSize!,
              style: textTheme.bodySmall?.copyWith(color: ProjectColors.textGray),
            ),
          ],

          const SizedBox(height: ProjectSizes.spaceBtwSections),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ProjectSizes.paddingLg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: macros.map((m) => NutritionMacroCircle(macro: m)).toList(),
            ),
          ),

          const SizedBox(height: ProjectSizes.spaceBtwSections + 4),

          NutritionDetailCard(macros: macros),

          const SizedBox(height: ProjectSizes.paddingLg),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ProjectSizes.pagePadding),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ProjectColors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusLg),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: ProjectSizes.paddingMd),
                  elevation: 0,
                ),
                child: Text(
                  l10n.nutrition_add_to_log,
                  style: textTheme.labelLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).padding.bottom + ProjectSizes.pagePadding,
          ),
        ],
      ),
    );
  }
}

class _BarcodeChip extends StatelessWidget {
  const _BarcodeChip({required this.barcode});
  final String barcode;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ProjectSizes.spaceBtwSections),
      padding: const EdgeInsets.symmetric(
        horizontal: ProjectSizes.paddingMd,
        vertical: ProjectSizes.paddingSm,
      ),
      decoration: BoxDecoration(
        color: ProjectColors.cardGray,
        borderRadius: BorderRadius.circular(ProjectSizes.imageAndCardRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.qr_code, size: ProjectSizes.iconSm, color: ProjectColors.textGray),
          const SizedBox(width: ProjectSizes.paddingSm),
          Text(
            barcode,
            style: textTheme.bodySmall?.copyWith(
              color: ProjectColors.textGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
