import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          _buildGridItem(context, 'View Expenses', '/page1'),
          _buildGridItem(context, 'View Budgets', '/page2'),
          _buildGridItem(context, 'Graphical View', '/page3'),
          _buildGridItem(context, 'Sign Out', '/page4'),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}

class ViewExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: Center(
        child: Text('View Expenses'),
      ),
    );
  }
}

class ViewBudgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budgets'),
      ),
      body: Center(
        child: Text('View Budgets'),
      ),
    );
  }
}

class ViewGraphical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graphical Graphs'),
      ),
      body: Center(
        child: Text('Graphical View'),
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Out'),
      ),
      body: Center(
        child: Text('Sign Out'),
      ),
    );
  }
}
