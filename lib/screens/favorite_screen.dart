import 'package:flutter/material.dart';
import '../provider/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/meal.item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;


    final List<Meal> favoriteMeals = Provider.of<MealProvider>(context ,listen: true).favoriteMeals;

    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favorites meal yet - start adding some!'),
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw<=400 ? 400:500,
          childAspectRatio: isLandscape ? dw/(dw*0.8) : dw/(dw*0.75),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            affordability: favoriteMeals[index].affordability,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
