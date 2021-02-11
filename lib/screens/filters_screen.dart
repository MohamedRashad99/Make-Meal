import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = 'filters';
  final Function saveFilters;
  final Map<String , bool > currentFilters;

  FiltersScreen(this.currentFilters ,this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  initState(){
     _glutenFree = widget.currentFilters['gluten'];
     _lactoseFree = widget.currentFilters['lactose'];
     _vegan = widget.currentFilters['vegan'];
     _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

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
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
              final Map<String, bool> selectedFilters={
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              // cause saveFilters is public function any widget is looked her.
              widget.saveFilters(selectedFilters);
            },
          ),
        ],
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
                  _glutenFree,
                  (val) => setState(
                    () {
                      _glutenFree = val;
                    },
                  ),
                ),
                buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals. ',
                  _lactoseFree,
                  (val) => setState(
                    () {
                      _lactoseFree = val;
                    },
                  ),
                ),
                buildSwitchListTile(
                  'Vegan-free',
                  'Only include vegan-free meals. ',
                  _vegan,
                  (val) => setState(
                    () {
                      _vegan = val;
                    },
                  ),
                ),
                buildSwitchListTile(
                  'Vegetarian-free',
                  'Only include vegetarian-free meals. ',
                  _vegetarian,
                  (val) => setState(
                    () {
                      _vegetarian = val;
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
