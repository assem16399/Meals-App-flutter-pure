import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const namedRoute = '/filter-screen';
  final Function onPress;
  final Map<String, bool> filtersState;
  FiltersScreen({this.onPress, this.filtersState});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.filtersState['Gluten Free'];
    _vegetarian = widget.filtersState['Vegetarian'];
    _vegan = widget.filtersState['Vegan'];
    _lactoseFree = widget.filtersState['Lactose Free'];
    super.initState();
  }

  Widget _buildFilterSwitch(
    bool currentValue,
    String specifiedMeals,
    String description,
    Function updateValue,
  ) {
    return SwitchListTile(
      value: currentValue,
      onChanged: updateValue,
      title: Text(specifiedMeals),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final Map<String, bool> selectedFilters = {
                  'Gluten Free': _glutenFree,
                  'Vegetarian': _vegetarian,
                  'Vegan': _vegan,
                  'Lactose Free': _lactoseFree,
                };
                widget.onPress(selectedFilters);
              })
        ],
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meals selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildFilterSwitch(_glutenFree, 'Gluten Free',
                    'only include Gluten Free Meals', (value) {
                  setState(() {
                    _glutenFree = value;
                  });
                  _glutenFree = value;
                }),
                _buildFilterSwitch(
                    _vegetarian, 'Vegetarian', 'only include Vegetarian Meals',
                    (value) {
                  setState(() {
                    _vegetarian = value;
                  });
                  _vegetarian = value;
                }),
                _buildFilterSwitch(_vegan, 'Vegan', 'only include Vegan Meals',
                    (value) {
                  setState(() {
                    _vegan = value;
                  });
                  _vegan = value;
                }),
                _buildFilterSwitch(
                    _lactoseFree, 'Lactose Free', 'only include Lactose Meals',
                    (value) {
                  setState(() {
                    _lactoseFree = value;
                  });
                  _lactoseFree = value;
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
