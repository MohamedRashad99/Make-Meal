import 'package:flutter/material.dart';
import 'package:meal_app/provider/language_provider.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  // we toked this data from category meal screen to show meals screen
  // but we now want to go meal details screen with this data plus id of each meal
  //-----------
  final String id;

  //-----------
 // final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;


  MealItem({
    @required this.id,
   // @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,

  });



  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
      // when i deleted expected items we must received it by id so we used then to received it and printing in console


      // tayb hwa hyt check meaId ely etb3tlo ka paramter like result kda okay ..
      // f fe removedItem be ttcheck  fe khlaha with constructor lakn hya fe asal gayah mn categories meals screen -->
    ).then((result) {
     // if(result != null) return removeItem(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return Directionality(
      
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,

      child: InkWell(
        onTap: () => selectMeal(context),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    child: Hero(
                      tag: id,
                      child: Image.network(
                        imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      width: 300,
                      color: Colors.black54,
                      child: Text(
                        lan.getTexts("meal-$id"),
                        style: TextStyle(fontSize: 26, color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule, color: Theme.of(context).buttonColor),
                        SizedBox(
                          height: 6,
                        ),
                        Text('$duration min'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.work, color: Theme.of(context).buttonColor),
                        SizedBox(
                          height: 6,
                        ),
                        Text(lan.getTexts('$complexity')),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money, color: Theme.of(context).buttonColor),
                        SizedBox(
                          height: 6,
                        ),
                        Text(lan.getTexts('$affordability')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
