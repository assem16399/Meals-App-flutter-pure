import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/categories-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  List<Meal> displayedMeals;
  String title;
  @override
  void didChangeDependencies() {
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final String id = routeArguments['id'];
    title = routeArguments['title'];
    displayedMeals = widget.availableMeals.where(
      (meal) {
        return meal.categories.contains(id);
      },
    ).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    void deleteItem(String id) {
      setState(() {
        displayedMeals.removeWhere((meal) => meal.id == id);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
          itemCount: displayedMeals.length,
          itemBuilder: (_, index) {
            return MealItem(
              id: displayedMeals[index].id,
              imageUrl: displayedMeals[index].imageUrl,
              title: displayedMeals[index].title,
              duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability,
            );
          }),
    );
  }
}
