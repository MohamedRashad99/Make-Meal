import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category.dart';
import '../models/meal.dart';
import '../dummy_data.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeal = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  List<String> prefsMealId = [];

  List<Category> availableCategory = [];

  void setFilters() async {
    /*يعني لو User فعل filters bottom هيروح يحدث filters من حاله false الي true ويروح بعد كده يعمل check
            ع حاجتين منهم يتاكد ان isGlutenFree ب false من ملف MealProviderProviderProviderProvider و كمان التغير التاني true
          لو الاتنين اتحققو يروح يمسح كل وجبات gluten بس لاحظ ان كل ده هيرجع في filterData*/
    availableMeal = DUMMY_MEALS.where((meal) {
      if (filters['gluten'] && !meal.isGlutenFree) {
        return false;
      }
      ;
      if (filters['lactose'] && !meal.isLactoseFree) {
        return false;
      }
      ;
      if (filters['vegan'] && !meal.isVegan) {
        return false;
      }
      ;
      if (filters['vegetarian'] && !meal.isVegetarian) {
        return false;
      }
      ;
      return true;
    }).toList();



    List<Category> ac = [];
    availableMeal.forEach((meal) {
      meal.categories.forEach((carId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if (cat.id == carId) {
            if (!ac.any((cat) => cat.id == carId)) ac.add(cat);
          }
        });
      });
    });
    availableCategory = ac;

    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten', filters['gluten']);
    prefs.setBool('lactose', filters['lactose']);
    prefs.setBool('vegan', filters['vegan']);
    prefs.setBool('vegetarian', filters['vegetarian']);
  }

  void getDataBySharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['lactose'] = prefs.getBool('lactose') ?? false;
    filters['vegan'] = prefs.getBool('vegan') ?? false;
    filters['vegetarian'] = prefs.getBool('vegetarian') ?? false;


    setFilters();


    prefsMealId = prefs.getStringList('prefsMealId') ?? [];
    for (var mealId in prefsMealId) {
      final existingIndex =
          favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));

        //لو العنصر موجود في List سيتم نقله الي قائمه المفضله
      }
    }


    List<Meal> fm = [];
    favoriteMeals.forEach((favMeals) {
      availableMeal.forEach((avMeal) {
        if (favMeals.id == avMeal.id) fm.add(favMeals);
      });
    });
    favoriteMeals = fm;

    notifyListeners();
  }

  void toggalFavorites(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    // لو العنصر موجود سيتم حذفه من قائمه المفضله
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
      ;
      //لو العنصر موجود في List سيتم نقله الي قائمه المفضله
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }

    notifyListeners();

    prefs.setStringList('prefsMealId', prefsMealId);
  } // ده عشان يتاكد من عمليه ال favorite من خلال ال star icon هل هو في خانه ال favorites ولا لا

  bool isFavorites(String mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }
}
