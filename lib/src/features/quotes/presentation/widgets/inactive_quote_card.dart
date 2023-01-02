import 'package:flutter/material.dart';
import 'package:statusesapp/src/features/quotes/data/models/quotes_model.dart';
import 'package:statusesapp/src/features/quotes/presentation/widgets/quote_card.dart';
import 'package:meta/meta.dart';
import 'package:statusesapp/src/shared/layout/responsive.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';

class InactiveQuoteCard extends StatelessWidget {
  final QuotesModel quote;
  final double bottom;
  final double right;
  final double left;
  final double cardWidth;
  final double rotation;
  final double skew;

  InactiveQuoteCard({
    @required this.quote,
    @required this.bottom,
    @required this.right,
    @required this.left,
    @required this.cardWidth,
    @required this.rotation,
    @required this.skew,
  });

  @override
  Widget build(BuildContext context) {
    return TargetPlatformWidget(
      materialWidget: Positioned(
          bottom: bottom + 150.hdp,
          child: QuoteCard(
            quote: quote,
            cardWidth: cardWidth,
          )),
    );
  }
}
