import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFavorite;
  final Function isFavorite;
  MealDetailScreen(this.toggleFavorite,this.isFavorite);
  Widget _buildSectionTitle(
    BuildContext context,
    String title,
  ) {
    return Container(
      child: Text(
        '$title:',
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget _buildSectionList(List<String> content, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey,
          )),
      height: MediaQuery.of(context).size.height * 0.22,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return Card(
            color: Theme.of(context).accentColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(content[index]),
            ),
          );
        }),
        itemCount: content.length,
      ),
    );
  }

  Widget _getFAB(
    BuildContext context,
    String id,
  ) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      children: [
        SpeedDialChild(
          label: 'Hide recipe from list',
          child: Icon(Icons.delete),
          onTap: () {
            Navigator.of(context).pop(id);
          },
        ),
        SpeedDialChild(
          label: 'Add/Remove Favorites',
          child: Icon(isFavorite(id) ? Icons.star : Icons.star_border),
          onTap: (){toggleFavorite(id);},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List<Object>;
    final String id = args[0];
    Color color = args[1];
    final selectedMeal = DUMMY_MEALS.firstWhere((meals) => meals.id == id);
    final appBar = AppBar(
      backgroundColor: color,
      title: Text(selectedMeal.title),
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButton: _getFAB(context, id),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          _buildSectionTitle(context, 'Ingredients'),
          _buildSectionList(selectedMeal.ingredients, context),
          _buildSectionTitle(context, 'Steps'),
          _buildSectionList(selectedMeal.steps, context)
        ],
      ),
    );
  }
}
