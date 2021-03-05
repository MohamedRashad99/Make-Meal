import 'package:flutter/material.dart';
import 'package:meal_app/provider/language_provider.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import 'package:meal_app/models/meal.dart';
import '../widgets/meal.item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category_meals';



  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
String categoryId;
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
    final List<Meal> availableMeals = Provider.of<MealProvider>(context ,listen: true).availableMeal;

    final routeArg =
    ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    // to make filtering all object that inside DUMMY_MEALS.
    // then convert to widget.availableMeals to  make filtering all object that inside categories.
    displayedMeal = availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,

      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getTexts('cat-$categoryId')),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: dw<=400 ? 400:500,
            childAspectRatio: isLandscape ? dw/(dw*0.8) : dw/(dw*0.75),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),

          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeal[index].id,
              imageUrl: displayedMeal[index].imageUrl,
              duration: displayedMeal[index].duration,
              affordability: displayedMeal[index].affordability,
              //removeItem: _removeMeal,
            );
          },
          itemCount: displayedMeal.length,
        ),
      ),
    );
  }
}
