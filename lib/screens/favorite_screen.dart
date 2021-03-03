import 'package:flutter/material.dart';
import '../provider/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/meal.item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Meal> favoriteMeals = Provider.of<MealProvider>(context ,listen: true).favoriteMeals;

    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favorites meal yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            imageUrl: favoriteMeals[index].imageUrl,
            title: favoriteMeals[index].title,
            duration: favoriteMeals[index].duration,
            affordability: favoriteMeals[index].affordability,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
