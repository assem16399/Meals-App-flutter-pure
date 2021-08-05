import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/widgets/Switch_between_ingredients_and_steps.dart';

class MealDetailsScreen extends StatelessWidget {
  static const namedRoute = '/meals-details';
  final Function onPress;
  final Function onFavouriteStatus;

  MealDetailsScreen(this.onPress, this.onFavouriteStatus);

  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String id = routeArguments['id'];
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == id);

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          onPressed: () => onPress(id),
          child: Icon((onFavouriteStatus(id) == true)
              ? Icons.favorite
              : Icons.favorite_border),
        ),
        appBar: AppBar(
          title: Text(selectedMeal.title),
        ),
        body: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SwitchBetweenIngredientsAndSteps(
              meal: selectedMeal,
            ),
          ],
        ));
  }
}
