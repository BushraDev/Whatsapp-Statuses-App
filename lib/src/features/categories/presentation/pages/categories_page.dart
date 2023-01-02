import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:statusesapp/src/features/categories/presentation/providers/categories_provider.dart';
import 'package:statusesapp/src/features/categories/presentation/widgets/category_card.dart';
import 'package:statusesapp/src/shared/error/exceptions.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';
import 'package:statusesapp/src/shared/messages/messages.dart';
import 'package:statusesapp/src/shared/widgets/custom_app_bar.dart';
import 'package:statusesapp/src/shared/widgets/error_widget.dart'
    as customErrorWidget;
import 'package:statusesapp/src/shared/layout/responsive.dart';
import 'package:statusesapp/src/shared/widgets/loading_widget.dart';

class CategoriesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return TargetPlatformWidget(
      materialWidget: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        /*appBar: CustomAppBar(
          title: AppMessages.home,
        ),*/
        body: _buildBody(context, watch),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ScopedReader watch) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: watch(categoriesFutureProvider).when(
        error: (e, s) {
          print(e.toString());
          print(e.runtimeType);
          if (e is CacheException)
            return customErrorWidget.ErrorWidget(
              message: e.message ?? AppMessages.cacheFailureMessage,
              provider: categoriesFutureProvider,
            );
          if (e is ServerException)
            return customErrorWidget.ErrorWidget(
              message: e.message,
              provider: categoriesFutureProvider,
            );
          return customErrorWidget.ErrorWidget(
            message: AppMessages.unexpectedError,
            provider: categoriesFutureProvider,
          );
        },
        loading: () => LoadingWidget(),
        data: (categories) {
          return RefreshIndicator(
            onRefresh: () {
              return context.refresh(categoriesFutureProvider);
            },
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.hdp,
                mainAxisSpacing: 12.hdp,
                childAspectRatio: 5.4 / 9,
              ),
              itemBuilder: (_, index) =>
                  CategoryCard(category: categories[index]),
              itemCount: categories.length,
              padding: EdgeInsets.only(bottom: 12.hdp),
            ),
          );
        },
      ),
    );
  }
}
