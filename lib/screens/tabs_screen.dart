import 'package:flutter/material.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorite_screen.dart';

import 'meal_detail_screen.dart';

class TabsScreen extends StatefulWidget {


  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int selectedPageIndex = 0;

  @override
  void initState() {
    // Not called im main function because this contain an context .
    Provider.of<MealProvider>(context ,listen: false).getDataBySharedPreference();
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(),
        'title': 'Your Favorites',
      },
    ];
    super.initState();
  }

  void _selectPage(int value) {
    setState(() {
      selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
