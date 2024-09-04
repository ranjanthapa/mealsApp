import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>>{
  // StateNotifier<List<Meal>> type of state data that is going to be manage
  FavouriteMealsNotifier() : super([]);

  bool toggleFavouriteMeal(Meal meal ){
    // state holds the data i.e list[meal]
    final isFavouriteMeal = state.contains(meal);
    if (isFavouriteMeal){
      // If it exists, remove it by creating a new list without that meal
      state = state.where((m)=> m.id != meal.id).toList();
      return false;
    }else{
      // If it does not exist, add it by creating a new list with the meal added
      state = [...state, meal]; // create
      return true;
    }
  }
}

final favouriteMealsProvider = StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>(
        (ref) => FavouriteMealsNotifier()
);


