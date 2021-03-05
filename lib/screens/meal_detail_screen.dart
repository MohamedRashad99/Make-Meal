import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/provider/language_provider.dart';
import 'package:provider/provider.dart';

import 'package:meal_app/provider/meal_provider.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meal_detail';

  Widget buildSelectionTitle(BuildContext ctx, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.headline1,
      ),
    );
  }

  Widget buildContainer(Widget child , BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.pink),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: isLandscape ? dw*0.5 : dw*0.25,
      width: isLandscape ? ( dh*0.5-25 ) : dh,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var accentColor = Theme.of(context).accentColor.withOpacity(0.2);

    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    // if id meal that come from categories meal is equal filtering meal that i has it

    List<String > stepsLi = lan.getTexts('steps-$mealId') as List<String >;
    var liSteps = ListView.builder(
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('#${index + 1}'),
            ),
            title: Text(
              stepsLi[index],
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black26,
          ),
        ],
      ),
      itemCount: stepsLi.length,
    );
    List<String>liIngredientLi =
        lan.getTexts('ingredients-$mealId') as List<String>;
    var liIngredients = ListView.builder(
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            liIngredientLi[index],
            style: TextStyle(
              color:
                  useWhiteForeground(accentColor) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      itemCount: liIngredientLi.length,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(lan.getTexts("meal-$mealId"))
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                child: Hero(
                  tag: mealId,
                  child: Image.network(
                    selectedMeal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            if(isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    buildSelectionTitle(context, 'ingredients'),
                    buildContainer(liIngredients ,context),
                  ],
                ),
                Column(
                  children: [
                    buildSelectionTitle(context, 'Steps'),
                    buildContainer(liSteps,context),
                  ],
                ),
              ],
            ),
            if(!isLandscape) buildSelectionTitle(context, 'ingredients'),
            if(!isLandscape) buildContainer(liIngredients,context),

            if(!isLandscape)buildSelectionTitle(context, 'Steps'),
            if(!isLandscape) buildContainer(liSteps,context),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // howa 3waz ydelete item f b3atlo mealId w mealId Gay mn meal item -->
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toggalFavorites(mealId),
        //star icon هل هو في خانه ال favorites ولا لا
        child: Icon(
            Provider.of<MealProvider>(context, listen: true).isFavorites(mealId)
                ? Icons.star
                : Icons.star_border),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
