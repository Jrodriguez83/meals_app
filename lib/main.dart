import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> favoriteMeals = [];

  List<Meal> meals = DUMMY_MEALS;

  void setFilters(Map<String, bool> data) {
    setState(() {
      _filters = data;
      meals = DUMMY_MEALS.where((meals) {
        if (_filters['gluten'] && !meals.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meals.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meals.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meals.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingMeal = favoriteMeals.indexWhere((favoriteMeal) {
      return favoriteMeal.id == mealId;
    });
    if (existingMeal >= 0) {
      setState(() {
        favoriteMeals.removeAt(existingMeal);
      });
    }else{
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal){
          return meal.id == mealId;
        }));
      });
    }
  }

  bool _isFavorite(String id){
    return favoriteMeals.any((favoriteMeal){
      return favoriteMeal.id == id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
            )),
      ),
      routes: {
        '/': (_) => TabsScreen(favoriteMeals),
        '/category-meal': (_) => CategoryMealsScreen(meals),
        '/meal-detail': (_) => MealDetailScreen(_toggleFavorite, _isFavorite),
        '/filters': (_) => FiltersScreen(_filters, setFilters)
      },
    );
  }
}
