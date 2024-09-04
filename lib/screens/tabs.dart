import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/screens/filter.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import '../provider/favourite_meal.dart';
import '../provider/filters_provider.dart';

const kInitialFilters = {
  Filter.vegan: false,
  Filter.vegetarian: false,
  Filter.lactoseFree: false,
  Filter.glutenFree: false
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filter") {
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (ctx) => const FilterScreen(
        ),
      ));
    }
    // return result;)
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealProvider);

    Widget activePage = CategoryScreen(
      availableMeal: availableMeals,
    );
    var defaultPageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider); // listens for any changes
      activePage = MealsScreen(
        meals: favouriteMeals,
      );
      defaultPageTitle = "Your Favourite";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(defaultPageTitle),
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
