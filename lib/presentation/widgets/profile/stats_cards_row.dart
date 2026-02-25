import 'package:flutter/material.dart';
import 'package:project_a/presentation/widgets/profile/stat_card.dart';
import 'package:project_a/utils/constants/sizes.dart';

class StatsCardsRow extends StatelessWidget {
  const StatsCardsRow({
    super.key,
    required this.cards,
    this.gap = ProjectSizes.spaceBtwItems,
    this.padding = 0.0,
    this.scrollable = true,
  });

  final List<StatCard> cards;
  // gap between cards
  final double gap;
  final double padding;
  // when false, cards are laid out without horizontal scrolling
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    if (scrollable) {
      final controller = ScrollController();
      return SingleChildScrollView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            children: [
              for (var i = 0; i < cards.length; i++) ...[
                cards[i],
                if (i < cards.length - 1) SizedBox(width: gap),
              ]
            ],
          ),
        ),
      );
    }

    // Non-scrollable: fit cards into available width
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            Expanded(child: cards[i]),
            if (i < cards.length - 1) SizedBox(width: gap),
          ]
        ],
      ),
    );
  }
}
