import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:statusesapp/src/features/quotes/presentation/providers/quotes_provider.dart';
import 'package:statusesapp/src/features/quotes/presentation/widgets/quotes_stack.dart';
import 'package:statusesapp/src/shared/error/exceptions.dart';
import 'package:statusesapp/src/shared/messages/messages.dart';
import 'package:statusesapp/src/shared/widgets/custom_app_bar.dart';
import 'package:statusesapp/src/shared/widgets/error_widget.dart'
    as customErrorWidget;
import 'package:meta/meta.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';
import 'package:statusesapp/src/shared/widgets/loading_widget.dart';

class QuotesPage extends ConsumerWidget {
  final String category;

  QuotesPage({@required this.category});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return TargetPlatformWidget(
      materialWidget: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(
          title: "$category ${AppMessages.statusesEn}",
        ),
        body: _buildBody(context, watch),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ScopedReader watch) {
    return watch(quotesByCategoryFutureProvider(category)).when(
      error: (e, s) {
        print(e.toString());
        print(e.runtimeType);
        if (e is CacheException)
          return customErrorWidget.ErrorWidget(
              message: e.message ?? AppMessages.cacheFailureMessage,
              provider: quotesByCategoryFutureProvider);
        if (e is ServerException)
          return customErrorWidget.ErrorWidget(
              message: e.message, provider: quotesByCategoryFutureProvider);
        return customErrorWidget.ErrorWidget(
            message: AppMessages.unexpectedError,
            provider: quotesByCategoryFutureProvider);
      },
      loading: () => LoadingWidget(),
      data: (quotes) {
        return RefreshIndicator(
          onRefresh: () {
            return context.refresh(quotesByCategoryFutureProvider(category));
          },
          child: QuotesStack(
            quotes: quotes,
            category: category,
          ),
        );
      },
    );
  }
}
