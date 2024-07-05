import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
              ], begin: Alignment.topLeft, end: Alignment.topRight),
            ),
            child: Row(children: [
              Icon(
                Icons.restaurant,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                width: 18,
              ),
              Text(
                "Crown Cafe",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              )
            ]),
          ),
          ListTile(
            leading: Icon(
              Icons.restaurant_menu_rounded,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "Meal",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24),
            ),
            onTap: () {
              onSelectScreen("meal");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "Filter",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary, fontSize: 24),
            ),
            onTap: () {
              onSelectScreen("filter");
            },
          )
        ],
      ),
    );
  }
}
