import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:statusesapp/src/features/categories/data/models/categories_model.dart';
import 'package:statusesapp/src/features/quotes/presentation/pages/quotes_page.dart';
import 'package:statusesapp/src/shared/assets/images.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';
import 'package:statusesapp/src/shared/layout/responsive.dart';

class CategoryCard extends StatelessWidget {
  final CategoriesModel category;

  CategoryCard({@required this.category});

  @override
  Widget build(BuildContext context) {
    return TargetPlatformWidget(
      materialWidget: InkWell(
        onTap: () {
          pushNewScreen(
            context,
            screen: QuotesPage(
              category: category.name,
            ),
            withNavBar: false,
          );
          /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QuotesPage(
                        category: category.name,
                      )));*/
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: AssetImage(
                            Images.category,
                          ),
                          fit: BoxFit.cover),
                      color: Theme.of(context).canvasColor),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.hdp),
                  child: Text(
                    category.name,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Theme.of(context).textTheme.headline6.color),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
