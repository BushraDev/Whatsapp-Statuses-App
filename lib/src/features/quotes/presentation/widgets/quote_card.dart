import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:statusesapp/src/features/favorites/domain/entities/add_quote_to_favorites_params.dart';
import 'package:statusesapp/src/features/favorites/domain/usecases/add_quote_to_favorites.dart';
import 'package:statusesapp/src/features/quotes/data/models/quotes_model.dart';
import 'package:meta/meta.dart';
import 'package:statusesapp/src/shared/messages/messages.dart';
import 'package:statusesapp/src/shared/methods.dart';
import 'package:statusesapp/src/shared/widgets/custom_chip.dart';
import '../../../../shared/widgets/rounded_icon.dart';
import '../../../../shared/di/get_it.dart' as di;
import 'package:statusesapp/src/shared/layout/responsive.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';

class QuoteCard extends StatelessWidget {
  final QuotesModel quote;
  final double cardWidth;

  QuoteCard({@required this.quote, this.cardWidth});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return TargetPlatformWidget(
      materialWidget: Container(
        width: screenSize.width / 1.2 + cardWidth,
        height: 390.hdp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).splashColor,
                  offset: Offset(0, 1.hdp),
                  blurRadius: 6.0.hdp,
                  spreadRadius: 3.0.hdp),
            ],
            color: Theme.of(context).cardColor),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: screenSize.width / 1.2 + cardWidth,
              height: 250.hdp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).scaffoldBackgroundColor),
              padding: EdgeInsets.all(20.hdp),
              margin: EdgeInsets.all(20.hdp),
              child: Center(
                child: Text(
                  quote.quote,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                      color: Theme.of(context).textTheme.headline6.color),
                ),
              ),
            ),
            Positioned(
                top: 250.hdp,
                child: Center(
                  child: CustomChip(
                    label: quote.author,
                  ),
                )),
            Positioned(
                top: 310.hdp,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedIcon(
                      onTap: () async {
                        print("fav button pressed");
                        try {
                          await di
                              .getItInstance<AddQuoteToFavorites>()
                              .call(AddQuoteToFavoritesParams(quote: quote))
                              .then((value) =>
                                  showShortToast(AppMessages.addFavoriteDone));
                        } catch (e) {
                          return showShortToast(
                              AppMessages.favoriteAlreadyAdded);
                        }
                      },
                      iconData: Icons.favorite,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 20.hdp,
                    ),
                    RoundedIcon(
                      onTap: () {
                        Share.share(quote.quote);
                      },
                      iconData: Icons.share,
                      color: Theme.of(context).unselectedWidgetColor,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
