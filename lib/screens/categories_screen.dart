import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/meal_provider.dart';
import '../widgets/category_item.dart';
import '../widgets/main_drawer.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: GridView(
        padding: EdgeInsets.all(16),
        children: Provider.of<MealProvider>(context).availableCategory
            .map(
              (catData) => CategoryItem(
                catData.id,
                catData.color,
              ),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
