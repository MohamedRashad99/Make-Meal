import 'package:flutter/material.dart';
import './dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_meal_screen.dart';
import './models/meal.dart';
//import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> _filterData) {
    setState(() {
      _filters = _filterData;
      /*يعني لو User فعل filters bottom هيروح يحدث filters من حاله false الي true ويروح بعد كده يعمل check
            ع حاجتين منهم يتاكد ان isGlutenFree ب false من ملف meal و كمان التغير التاني true
          لو الاتنين اتحققو يروح يمسح كل وجبات gluten بس لاحظ ان كل ده هيرجع في filterData*/
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        ;
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        ;
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        ;
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        ;
        return true;
      }).toList();
    });
  }
  void _toggalFavorites(String mealId){
  final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id==mealId);
  // لو العنصر موجود سيتم حذفه من قائمه المفضله
  if(existingIndex >=0){
    setState(() {
      _favoriteMeals.removeAt(existingIndex);
    });
    //لو العنصر موجود في List سيتم نقله الي قائمه المفضله
  }else{
    setState(() {
      _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
    });
  }
  }// ده عشان يتاكد من عمليه ال favorite من خلال ال star icon هل هو في خانه ال favorites ولا لا
  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.orangeAccent,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                headline1: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
      // home: MyHomePage(),
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggalFavorites,_isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal App'),
      ),
      body: null,
    );
  }
}
