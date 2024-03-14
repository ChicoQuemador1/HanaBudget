import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/page1': (context) => ViewExpenses(),
        '/page2': (context) => ViewBudgets(),
        '/page3': (context) => ViewGraphical(),
        '/page4': (context) => SignOutButton(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
