import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meals_item.dart';

class MealsScreen extends StatelessWidget {
  final List<Meal> meals;
  final String? title;

  const MealsScreen(
      {super.key,
      required this.meals,
      this.title,
      });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "opps...the bucket is empty",
            style: themeData.textTheme.headlineLarge!
                .copyWith(color: themeData.colorScheme.onBackground),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Try adding something in menu",
            style: themeData.textTheme.bodyLarge!
                .copyWith(color: themeData.colorScheme.onBackground),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(
                meal: meals[index],
              ));
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
