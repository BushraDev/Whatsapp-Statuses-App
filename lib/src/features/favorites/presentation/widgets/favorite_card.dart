import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:share/share.dart';
import 'package:statusesapp/src/features/favorites/domain/entities/remove_quote_from_favorites_params.dart';
import 'package:statusesapp/src/features/favorites/domain/usecases/remove_quote_from_favorites.dart';
import 'package:statusesapp/src/features/quotes/data/models/quotes_model.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';
import 'package:statusesapp/src/shared/messages/messages.dart';
import 'package:statusesapp/src/shared/methods.dart';
import 'package:statusesapp/src/shared/widgets/custom_chip.dart';
import '../../../../shared/di/get_it.dart' as di;
import 'package:statusesapp/src/shared/layout/responsive.dart';

class FavoriteCard extends StatelessWidget {
  final QuotesModel quote;

  FavoriteCard({@required this.quote});

  @override
  Widget build(BuildContext context) {
    return TargetPlatformWidget(
      materialWidget: Container(
        margin: EdgeInsets.only(bottom: 20.hdp),
        padding:
            const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
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
        child: Column(
          textDirection: TextDirection.ltr,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomChip(
              label: quote.author,
            ),
            SizedBox(
              height: 15.hdp,
            ),
            Text(
              quote.quote,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: Theme.of(context).textTheme.headline6.color),
            ),
            SizedBox(
              height: 15.hdp,
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              height: 5.hdp,
            ),
            SizedBox(
              height: 10.hdp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    _showRemoveFavoriteDialog(context);
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Share.share(quote.quote);
                  },
                  child: Icon(
                    Icons.share,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _showRemoveFavoriteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(AppMessages.removeFavorite),
              content: new Text(AppMessages.confirmRemoveFavorite),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    AppMessages.remove,
                    style: TextStyle(
                        color: Theme.of(context).unselectedWidgetColor),
                  ),
                  onPressed: () async {
                    await di
                        .getItInstance<RemoveQuoteFromFavorites>()
                        .call(RemoveQuoteFromFavoritesParams(quote: quote))
                        .then((value) {
                      print("this is remove result $value");
                      if (value == 1) {
                        Navigator.of(context, rootNavigator: true).pop();
                        showShortToast(AppMessages.removeFavoriteDone);
                      } else {
                        Navigator.of(context, rootNavigator: true).pop();
                        showShortToast(AppMessages.favoriteAlreadyRemoved);
                      }
                    });
                  },
                ),
                FlatButton(
                  child: Text(
                    AppMessages.cancel,
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            ));
  }
}
