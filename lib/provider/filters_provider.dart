import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';
import 'meal_provider.dart';

enum Filter { glutenFree, vegan, lactoseFree, vegetarian }


class FilterNotifier extends StateNotifier<Map<Filter, bool>>{
  FilterNotifier() : super({
    Filter.vegan : false,
    Filter.glutenFree: false,
    Filter.vegetarian : false,
    Filter.lactoseFree: false
  });
  void setFilter(Filter filter, bool isActive){
    state = {
      ...state,
      filter: isActive
    };
  }
  void setFilters(Map<Filter, bool> chosenFilters){
    state = chosenFilters;
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
        (ref) =>  FilterNotifier());


final filterMealProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    return true;
  }).toList();
});


