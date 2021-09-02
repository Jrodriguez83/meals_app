import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  final Function setFilters;
  final Map<String,bool> filters;
  FiltersScreen(this.filters,this.setFilters);
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegan = false;
  var _vegetarian = false;

  @override
  void initState() {
    _glutenFree = widget.filters['gluten'];
    _lactoseFree=widget.filters['lactose'];
    _vegetarian = widget.filters['vegetarian'];
    _vegan = widget.filters['vegan'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final _filters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.setFilters(_filters);
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(_glutenFree, 'Gluten-Free', (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                  _lactoseFree,
                  'Lactose-Free',
                  (newValue){
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }
                ),
                _buildSwitchListTile(
                  _vegan,
                  'Vegan',
                  (newValue){
                    setState(() {
                      _vegan = newValue;
                    });
                  }
                ),
                _buildSwitchListTile(
                  _vegetarian,
                  'Vegetarian',
                  (newValue){
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  SwitchListTile _buildSwitchListTile(
    bool currentValue,
    String title,
    Function updateValue,
  ) {
    return SwitchListTile(
      subtitle: Text('Only include $title meals'),
      title: Text(title),
      value: currentValue,
      onChanged: updateValue,
    );
  }
}
