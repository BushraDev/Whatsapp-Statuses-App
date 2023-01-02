import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:statusesapp/src/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:statusesapp/src/features/favorites/presentation/widgets/favorite_card.dart';
import 'package:statusesapp/src/shared/error/exceptions.dart';
import 'package:statusesapp/src/shared/messages/messages.dart';
import 'package:statusesapp/src/shared/widgets/custom_app_bar.dart';
import 'package:statusesapp/src/shared/widgets/error_widget.dart'
    as customErrorWidget;
import 'package:statusesapp/src/shared/widgets/loading_widget.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';
import 'package:statusesapp/src/shared/layout/responsive.dart';

class FavoritesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return TargetPlatformWidget(
      materialWidget: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        /*appBar: CustomAppBar(
          title: AppMessages.favorites,
        ),*/
        body: _buildBody(context, watch),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ScopedReader watch) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.hdp),
      child: watch(favoriteQuotesFutureProvider).when(
        error: (e, s) {
          print(e.toString());
          print(e.runtimeType);
          if (e is CacheException)
            return customErrorWidget.ErrorWidget(
                message: e.message ?? AppMessages.cacheFailureMessage,
                provider: favoriteQuotesFutureProvider);
          return customErrorWidget.ErrorWidget(
              message: AppMessages.unexpectedError,
              provider: favoriteQuotesFutureProvider);
        },
        loading: () => LoadingWidget(),
        data: (quotes) {
          return RefreshIndicator(
              onRefresh: () {
                return context.refresh(favoriteQuotesFutureProvider);
              },
              child: ListView.builder(
                itemBuilder: (context, index) => FavoriteCard(
                  quote: quotes[index],
                ),
                itemCount: quotes.length,
              ));
        },
      ),
    );
  }
}
