import 'package:flutter/material.dart';

enum Filter { glutenFree, vegan, lactoseFree, vegetarian }

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilter});
  final Map<Filter, bool> currentFilter;

  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFilterSet = false;
  var _lactusFilterSet = false;
  var _veganFilterSet = false;
  var _vegetarianFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFilterSet = widget.currentFilter[Filter.glutenFree]!;
    _lactusFilterSet = widget.currentFilter[Filter.lactoseFree]!;
    _veganFilterSet = widget.currentFilter[Filter.vegan]!;
    _vegetarianFilterSet = widget.currentFilter[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.vegan: _veganFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.lactoseFree: _lactusFilterSet,
            Filter.glutenFree: _glutenFilterSet
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFilterSet = isChecked;
                });
              },
              title: Text(
                "Gluten Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Only include gluten free meals",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _lactusFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactusFilterSet = isChecked;
                });
              },
              title: Text(
                "Lactus Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Only include lactus free meals",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Only include vegan meals",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _vegetarianFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
              title: Text(
                "Vegetarian",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Only include vegetarian meals",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
