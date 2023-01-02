import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:statusesapp/src/features/quotes/data/models/quotes_model.dart';
import 'package:meta/meta.dart';
import 'package:statusesapp/src/features/quotes/presentation/providers/quotes_provider.dart';
import 'package:statusesapp/src/features/quotes/presentation/widgets/active_quote_card.dart';
import 'package:statusesapp/src/features/quotes/presentation/widgets/inactive_quote_card.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:statusesapp/src/shared/layout/responsive.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';
import 'package:statusesapp/src/shared/messages/messages.dart';

class QuotesStack extends StatefulWidget {
  final List<QuotesModel> quotes;
  final String category;

  QuotesStack({@required this.quotes, @required this.category});

  @override
  _QuotesStackState createState() => _QuotesStackState();
}

class _QuotesStackState extends State<QuotesStack>
    with SingleTickerProviderStateMixin {
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;

  List selectedData = [];

  @override
  void initState() {
    super.initState();

    _buttonController = new AnimationController(
        duration: new Duration(seconds: 1), vsync: this);

    rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = widget.quotes.removeLast();
          widget.quotes.insert(0, i);

          _buttonController.reset();
        }
      });
    });

    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 10.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  dismissCard(QuotesModel quote) {
    setState(() {
      widget.quotes.remove(quote);
    });
  }

  addCard(QuotesModel quote) {
    setState(() {
      widget.quotes.remove(quote);
      selectedData.add(quote);
    });
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;

    double initialBottom = 15.0.hdp;
    var dataLength = widget.quotes.length;
    double backCardPosition =
        initialBottom + (dataLength - 1.hdp) * 10.hdp + 10.hdp;
    double backCardWidth = -10.0.hdp;
    return TargetPlatformWidget(
      materialWidget: widget.quotes.length > 0
          ? Stack(
              //overflow: Overflow.visible,
              alignment: Alignment.center,
              children: widget.quotes.map((quote) {
                if (widget.quotes.indexOf(quote) == dataLength - 1) {
                  return ActiveQuoteCard(
                    quote: quote,
                    skew: rotate.value < -10.hdp ? 0.1.hdp : 0.0,
                    rotation: rotate.value,
                    right: right.value,
                    bottom: bottom.value,
                    left: 0.0,
                    dismissQuote: dismissCard,
                    cardWidth: backCardWidth + 10.hdp,
                    flag: flag,
                    addQuote: addCard,
                    swipeRight: swipeRight,
                    swipeLeft: swipeLeft,
                  );
                } else {
                  backCardPosition = backCardPosition - 10.hdp;
                  backCardWidth = backCardWidth + 10.hdp;

                  return InactiveQuoteCard(
                    quote: quote,
                    bottom: backCardPosition,
                    cardWidth: backCardWidth,
                  );
                }
              }).toList(),
            )
          : Consumer(
              builder: (context, watch, child) => RefreshIndicator(
                onRefresh: () {
                  return context
                      .refresh(quotesByCategoryFutureProvider(widget.category));
                },
                child: Center(
                  child: Text(AppMessages.emptyList),
                ),
              ),
            ),
    );
  }
}
