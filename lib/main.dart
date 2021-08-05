import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/categories_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_details_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favouriteMeals = [];

  Map<String, bool> filtersState = {
    'Gluten Free': false,
    'Vegetarian': false,
    'Vegan': false,
    'Lactose Free': false,
  };

  void setFilters(
    Map<String, bool> selectedFilters,
  ) {
    setState(() {
      filtersState = selectedFilters;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (filtersState['Gluten Free'] && !meal.isGlutenFree) return false;
        if (filtersState['Lactose Free'] && !meal.isLactoseFree) return false;
        if (filtersState['Vegan'] && !meal.isVegan) return false;
        if (filtersState['Vegetarian'] && !meal.isVegetarian)
          return false;
        else
          return true;
      }).toList();
    });
  }
// ***********Another logic to toggle the favorites********//

  /* void toggleFavorites(String mealId) {
    final existingIndex =
        favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }
*/

  void toggleFavoritesNewVer(String mealId) {
    DUMMY_MEALS.any((meal) {
      if (meal.id == mealId) {
        if (!favouriteMeals.contains(meal)) {
          setState(() {
            favouriteMeals.add(meal);
          });
        } else if (favouriteMeals.contains(meal)) {
          setState(() {
            favouriteMeals.remove(meal);
          });
        }
        return true;
      } else
        return false;
    });
  }

  bool isMealFavorite(String mealId) {
    if (favouriteMeals.any((meal) => meal.id == mealId))
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.yellow,
        canvasColor: Color.fromRGBO(220, 255, 220, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 1, 1),
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 1, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      routes: {
        '/': (_) => TabsScreen(favoriteMeals: favouriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals),
        MealDetailsScreen.namedRoute: (ctx) =>
            MealDetailsScreen(toggleFavoritesNewVer, isMealFavorite),
        FiltersScreen.namedRoute: (ctx) => FiltersScreen(
              filtersState: filtersState,
              onPress: setFilters,
            ),
      },
      // onGenerateRoute: (RouteSettings routeSettings) {print(routeSettings.arguments);
      // return MaterialPageRoute(builder: (ctx)=>CategoriesScreen());}
      onUnknownRoute: (RouteSettings routeSettings) {
        print(routeSettings.arguments);
        return MaterialPageRoute(builder: (ctx) => TabsScreen());
      },
    );
  }
}
