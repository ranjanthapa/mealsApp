import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import "package:meals_app/models/meal.dart";

class CategoryScreen extends StatefulWidget {
  const CategoryScreen(
      {super.key,
      required this.availableMeal});
  final List<Meal> availableMeal;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this,
    duration: const Duration(milliseconds: 300),
      lowerBound:0,
      upperBound: 1
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filterMeal = widget.availableMeal
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          meals: filterMeal,
          title: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 20),
          children: [
            ...availableCategories.map((category) => CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ))
          ],
        ),

        builder: (context, child) => SlideTransition(position: Tween(
          begin: const Offset(0, 0.3),
          end:const  Offset(0,0),
        ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
          child: child,
        )
    );
  }
}
