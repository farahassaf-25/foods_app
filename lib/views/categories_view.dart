import 'package:flutter/material.dart';
import 'package:foods_app/data/data.dart';
import 'package:foods_app/models/category_model.dart';
import 'package:foods_app/views/meals_view.dart';
import 'package:foods_app/widgets/category_grid_item.dart';

import '../models/meal_model.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView(
      {super.key,
      required this.onToggleFavorite,
      required this.availableMeals});

  final List<MealModel> availableMeals;
  final void Function(MealModel meal) onToggleFavorite;

  void _selectCategory(BuildContext context, CategoryModel category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsView(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
