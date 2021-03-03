import 'package:flutter/material.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = 'filters';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {


  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      activeColor: Theme.of(context).primaryColor,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Your Filters'),

      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals. ',
                  currentFilters['gluten'],
                  (val) {
                    setState(() {
                      currentFilters['gluten'] = val;
                    });
                    Provider.of<MealProvider>(context, listen: false).setFilters();
                  },
                ),
                buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals. ',
                  currentFilters['lactose'],
                  (val) {
                    setState(() {
                      currentFilters['lactose'] = val;
                    });
                    Provider.of<MealProvider>(context, listen: false).setFilters();
                  },
                ),
                buildSwitchListTile(
                  'Vegan-free',
                  'Only include vegan-free meals. ',
                  currentFilters['vegan'],
                  (val) {
                    setState(() {
                      currentFilters['vegan'] = val;
                    });
                    Provider.of<MealProvider>(context, listen: false).setFilters();
                  },
                ),
                buildSwitchListTile(
                  'Vegetarian-free',
                  'Only include vegetarian-free meals. ',
                  currentFilters['vegetarian'],
                  (val) {
                    setState(() {
                      currentFilters['vegetarian'] = val;
                    });
                    Provider.of<MealProvider>(context, listen: false).setFilters();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
