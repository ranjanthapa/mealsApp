import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
import "package:meals_app/models/meal.dart";
import 'package:meals_app/screens/filter.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.vegan: false,
  Filter.vegetarian: false,
  Filter.lactoseFree: false,
  Filter.glutenFree: false
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
        _showInfoMessage("Meal remove from the favourite list");
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        _showInfoMessage("Meal added to the favourite list");
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filter") {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (ctx) => FilterScreen(
          currentFilter: _selectedFilters,
        ),
      ));
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
      print(result);
    }
    // return result;)
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoryScreen(
      onToggleFavourite: _toggleMealFavouriteStatus,
      availableMeal: availableMeals,
    );
    var defaulPageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavourite: _toggleMealFavouriteStatus,
      );
      defaulPageTitle = "Your Favourite";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(defaulPageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourite"),
        ],
      ),
    );
  }
}
