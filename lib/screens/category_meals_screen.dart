import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
// import '../dummy_data.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  final List<Meal> meals;
  CategoryMealsScreen(this.meals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String title;
  var _loadedInitialData = false;
  List<Meal> meals;
  Color color;
  @override
  void didChangeDependencies() {
    if (!_loadedInitialData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;

      title = routeArgs['title'];
      final id = routeArgs['id'];
      color = routeArgs['color'];

      meals = widget.meals.where((meals) {
        return meals.categories.contains(id);
      }).toList();
      _loadedInitialData = true;
    }

    super.didChangeDependencies();
  }

  void _removeItem(String newId) {
    setState(() {
      meals.removeWhere((meals) => meals.id == newId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
            color: color,
            id: widget.meals[index].id,
            affordability: meals[index].affordability,
            complexity: meals[index].complexity,
            duration: meals[index].duration,
            imageUrl: meals[index].imageUrl,
            title: meals[index].title,
            removeItem: _removeItem,
          );
        }),
        itemCount: meals.length,
      ),
    );
  }
}
