import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hanabudget/screens/main_page.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  width: size.width,
                  height: size.height * 0.20,
                  color: Color(0xFF1ED891),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: const MainScreen(), // Positioned on top of the Column
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF1ED891),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.account_balance),
              onPressed: () {
                MainScreen();
              },
            ),
            IconButton(
              icon: Icon(Icons.account_balance_wallet_outlined),
              onPressed: () {},
            ),
            SizedBox(
                width: 48), // The empty space for the floating action button
            IconButton(
              icon: Icon(Icons.bar_chart_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                var settingsBox = await Hive.openBox('settingsBox');
                await settingsBox.delete('loggedInUser');
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
