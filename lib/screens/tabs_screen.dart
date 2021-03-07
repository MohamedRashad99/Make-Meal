import 'package:flutter/material.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:meal_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import '../provider/language_provider.dart';

import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = 'tabs_screen';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int selectedPageIndex = 0;

  @override
  void initState() {
    // Not called im main function because this contain an context .
    Provider.of<MealProvider>(context, listen: false)
        .getDataBySharedPreference();
    Provider.of<ThemeProvider>(context, listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context, listen: false).getThemeColor();
    Provider.of<LanguageProvider>(context, listen: false).getLan();

    super.initState();
  }

  void _selectPage(int value) {
    setState(() {
      selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    _pages = [
      {
        'page': CategoriesScreen(),
        'title': lan.getTexts('categories'),
      },
      {
        'page': FavoritesScreen(),
        'title': lan.getTexts('your_favorites'),
      },
    ];

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text(_pages[selectedPageIndex]['title']),
        ),
        body: _pages[selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          currentIndex: selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: lan.getTexts('categories'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: lan.getTexts('your_favorites'),
            ),
          ],
        ),
      ),
    );
  }
}
