import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class SwitchBetweenIngredientsAndSteps extends StatefulWidget {
  final Meal meal;

  SwitchBetweenIngredientsAndSteps({this.meal});

  @override
  _SwitchBetweenIngredientsAndStepsState createState() =>
      _SwitchBetweenIngredientsAndStepsState();
}

class _SwitchBetweenIngredientsAndStepsState
    extends State<SwitchBetweenIngredientsAndSteps> {
  var switchStatus = false;
  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildSwitchSelection(
      {BuildContext context, String title, List<String> switchChoice}) {
    return Column(
      children: [
        buildSectionTitle(context, title),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          width: 300,
          height: 250,
          child: ListView.builder(
            itemCount: switchChoice.length,
            itemBuilder: (ctx, index) => (switchChoice == widget.meal.steps)
                ? Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(switchChoice[index]),
                      ),
                      Divider()
                    ],
                  )
                : Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(switchChoice[index]),
                    ),
                  ),
          ),
        )
      ],
    );
  }

  void onSwitched(value) {
    setState(() {
      switchStatus = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Switch to show Steps',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Switch(
              value: switchStatus,
              onChanged: onSwitched,
            ),
          ],
        ),
        (switchStatus == true)
            ? buildSwitchSelection(
                title: 'Steps',
                context: context,
                switchChoice: widget.meal.steps)
            : buildSwitchSelection(
                title: 'Ingredients',
                context: context,
                switchChoice: widget.meal.ingredients)
      ],
    );
  }
}
