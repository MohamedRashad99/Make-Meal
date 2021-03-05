import 'package:flutter/material.dart';
import 'package:meal_app/provider/theme_provider.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_meal_screen.dart';
import 'provider/language_provider.dart';
import 'provider/meal_provider.dart';
import 'screens/on_boarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget homeScreen = (prefs.getBool('watched')?? false)? TabsScreen():OnBoardingScreen();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MealProvider>(
          create: (ctx) => MealProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (ctx) => ThemeProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (ctx) => LanguageProvider(),
        ),
      ],
      child: MyApp(homeScreen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget mainScreen;
  MyApp(this.mainScreen);

  @override
  Widget build(BuildContext context) {

    var primaryColor = Provider.of<ThemeProvider>(context,listen: true).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context,listen: true).accentColor;
    var tm = Provider.of<ThemeProvider>(context,listen: true).tm;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: tm,
      theme: ThemeData(
          primarySwatch: primaryColor,
          accentColor: accentColor,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          buttonColor: Colors.black87,
          cardColor: Colors.white,
          shadowColor: Colors.black54,
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline1: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              )),
      darkTheme: ThemeData(
          primarySwatch: primaryColor,
          accentColor: accentColor,
          canvasColor: Color.fromRGBO(14, 22, 33, 1),
          buttonColor: Colors.white60,
          cardColor: Color.fromRGBO(35, 34, 39, 1),
          shadowColor: Colors.white60,
          unselectedWidgetColor:Colors.white70 ,
          textTheme: ThemeData.dark().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Colors.white60,
                ),
                headline1: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              )),
      // home: MyHomePage(),
      routes: {
        '/': (ctx) => mainScreen,
        TabsScreen.routeName: (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
        ThemesScreen.routeName: (context) => ThemesScreen(),

      },
    );
  }
}




