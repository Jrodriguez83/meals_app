import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildListTile({String title, IconData icon, Function onPressed}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'Quicksand', fontSize: 24, fontWeight: FontWeight.bold),
      ),
      onTap: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildListTile(
            title: 'Meals',
            icon: Icons.restaurant,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          _buildListTile(
            title: 'Filters',
            icon: Icons.settings,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/filters');
            },
          ),
        ],
      ),
    );
  }
}
