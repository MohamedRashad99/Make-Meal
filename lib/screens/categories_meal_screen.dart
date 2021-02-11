import 'package:flutter/material.dart';
import '../models/category.dart';
import 'package:meal_app/models/meal.dart';
import '../widgets/meal.item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category_meals';

  final List<Meal> availableMeals;

 CategoryMealsScreen(this.availableMeals );

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeal;


  //// ------>
  // hena b2a alasal Fuction ely ha delete el item
  void _removeMeal(String mealId) {
    setState(() {
      displayedMeal.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  void didChangeDependencies() {
    final routeArg =
    ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title'];
    // to make filtering all object that inside DUMMY_MEALS.
    // then convert to widget.availableMeals to  make filtering all object that inside categories.
    displayedMeal = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeal[index].id,
            imageUrl: displayedMeal[index].imageUrl,
            title: displayedMeal[index].title,
            duration: displayedMeal[index].duration,
            affordability: displayedMeal[index].affordability,
            //removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeal.length,
      ),
    );
  }
}
