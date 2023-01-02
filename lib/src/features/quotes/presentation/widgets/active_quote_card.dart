import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:statusesapp/src/features/quotes/data/models/quotes_model.dart';
import 'package:statusesapp/src/features/quotes/presentation/widgets/quote_card.dart';
import 'package:statusesapp/src/shared/layout/responsive.dart';

class ActiveQuoteCard extends StatelessWidget {
  final QuotesModel quote;
  final double skew;
  final double rotation;
  final double bottom;
  final double right;
  final double left;
  final double cardWidth;
  final int flag;
  final Function addQuote;
  final Function dismissQuote;
  final Function swipeRight;
  final Function swipeLeft;

  ActiveQuoteCard(
      {@required this.quote,
      @required this.skew,
      @required this.rotation,
      @required this.right,
      @required this.bottom,
      @required this.dismissQuote,
      @required this.swipeRight,
      @required this.left,
      @required this.addQuote,
      @required this.cardWidth,
      @required this.flag,
      @required this.swipeLeft});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom + 150.hdp,
      right: flag == 0
          ? right != 0.0
              ? right
              : null
          : null,
      left: flag == 1
          ? right != 0.0
              ? right
              : null
          : null,
      child: new Dismissible(
        key: UniqueKey(),
        crossAxisEndOffset: -0.3,
        onResize: () {},
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart)
            dismissQuote(quote);
          else
            addQuote(quote);
        },
        child: Transform(
          alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
          transform: new Matrix4.skewX(skew),
          child: RotationTransition(
            turns: new AlwaysStoppedAnimation(
                flag == 0 ? rotation / 360 : -rotation / 360),
            child: Hero(
              tag: quote.quote,
              child: GestureDetector(
                onTap: () {
                  swipeRight();
                },
                child: QuoteCard(
                  quote: quote,
                  cardWidth: cardWidth,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
