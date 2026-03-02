import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/main.dart';
import 'package:project_a/data/models/nutrition/ai_nutrition_result_model.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/presentation/bloc/nutrition/nutrition_result_bloc.dart';
import 'package:project_a/presentation/bloc/nutrition/nutrition_result_event.dart';
import 'package:project_a/presentation/bloc/nutrition/nutrition_result_state.dart';
import 'package:project_a/presentation/widgets/nutrition/nutrition_detail_card.dart';
import 'package:project_a/presentation/widgets/nutrition/nutrition_macro.dart';
import 'package:project_a/presentation/widgets/nutrition/nutrition_macro_circle.dart';
import 'package:project_a/presentation/widgets/nutrition/nutrition_photo_section.dart';
import 'package:project_a/shared/widgets/snackbar/custom_snackbar.dart';
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

    return BlocListener<NutritionResultBloc, NutritionResultState>(
      listener: (context, state) {
        if (state is NutritionLogSuccess) {
          nutritionLoggedNotifier.value++;
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state is NutritionLogError) {
          AppSnackbar.showError(context, message: state.message);
        }
      },
      child: Scaffold(
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

            final AiNutritionResultModel result;
            final bool isLogging;

            if (state is NutritionLogLoading) {
              result = state.result;
              isLogging = true;
            } else if (state is NutritionLogError) {
              result = state.result;
              isLogging = false;
            } else {
              result = (state as NutritionResultLoaded).result;
              isLogging = false;
            }

            return _NutritionContent(
              result: result,
              photoPath: photoPath,
              barcode: barcode,
              mode: mode,
              isLogging: isLogging,
            );
          },
        ),
      ),
    );
  }
}

class _NutritionContent extends StatefulWidget {
  const _NutritionContent({
    required this.result,
    required this.photoPath,
    required this.barcode,
    required this.mode,
    required this.isLogging,
  });

  final AiNutritionResultModel result;
  final String? photoPath;
  final String? barcode;
  final String mode;
  final bool isLogging;

  @override
  State<_NutritionContent> createState() => _NutritionContentState();
}

class _NutritionContentState extends State<_NutritionContent> {
  String _selectedMealType = 'breakfast';

  static const _mealTypes = [
    ('breakfast', 'Kahvaltı'),
    ('lunch', 'Öğle'),
    ('snacks', 'Atıştırmalık'),
    ('dinner', 'Akşam'),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    final macros = [
      NutritionMacro(
        name: l10n.nutrition_fat,
        grams: widget.result.fat.round(),
        dailyTarget: 65,
        color: const Color(0xFFF9D56E),
      ),
      NutritionMacro(
        name: l10n.nutrition_protein,
        grams: widget.result.protein.round(),
        dailyTarget: 50,
        color: const Color(0xFFFA8072),
      ),
      NutritionMacro(
        name: l10n.nutrition_carb,
        grams: widget.result.carbs.round(),
        dailyTarget: 130,
        color: const Color(0xFF87CEEB),
      ),
      if (widget.result.fiber != null)
        NutritionMacro(
          name: l10n.nutrition_fiber,
          grams: widget.result.fiber!.round(),
          dailyTarget: 25,
          color: const Color(0xFFB5EAD7),
        ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: ProjectSizes.paddingSm),

          if (widget.photoPath != null) NutritionPhotoSection(photoPath: widget.photoPath!),

          if (widget.barcode != null) ...[
            const SizedBox(height: ProjectSizes.paddingSm + 4),
            _BarcodeChip(barcode: widget.barcode!),
          ],

          if (widget.result.name.isNotEmpty) ...[
            const SizedBox(height: ProjectSizes.paddingMd),
            Text(
              widget.result.name,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],

          const SizedBox(height: ProjectSizes.paddingLg),

          Text(
            '${widget.result.calories.round()} ${l10n.nutrition_kcal_suffix}',
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: ProjectSizes.paddingSm),
          Text(
            widget.mode == 'barcode'
                ? l10n.nutrition_portion_single
                : l10n.nutrition_portion_estimated,
            style: textTheme.bodySmall?.copyWith(color: ProjectColors.textGray),
          ),

          if (widget.result.portionSize != null) ...[
            const SizedBox(height: 4),
            Text(
              widget.result.portionSize!,
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

          // Meal type selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ProjectSizes.pagePadding),
            child: Wrap(
              spacing: 8,
              children: _mealTypes.map((entry) {
                final (key, label) = entry;
                final isSelected = _selectedMealType == key;
                return ChoiceChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: widget.isLogging
                      ? null
                      : (_) => setState(() => _selectedMealType = key),
                  selectedColor: ProjectColors.orange,
                  backgroundColor: ProjectColors.cardGray,
                  labelStyle: textTheme.bodySmall?.copyWith(
                    color: isSelected ? Colors.white : ProjectColors.textGray,
                    fontWeight: FontWeight.w500,
                  ),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  showCheckmark: false,
                  padding: const EdgeInsets.symmetric(
                    horizontal: ProjectSizes.paddingSm,
                    vertical: 4,
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: ProjectSizes.paddingMd),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ProjectSizes.pagePadding),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.isLogging
                    ? null
                    : () {
                        context.read<NutritionResultBloc>().add(
                              LogNutrition(
                                result: widget.result,
                                mealType: _selectedMealType,
                              ),
                            );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ProjectColors.orange,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: ProjectColors.orange.withAlpha(153),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusLg),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: ProjectSizes.paddingMd),
                  elevation: 0,
                ),
                child: widget.isLogging
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
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
