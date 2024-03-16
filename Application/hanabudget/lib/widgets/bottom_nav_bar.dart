import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Color(0xff368983),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.account_balance,
                  size: 30,
                  color: Color(0xff368983),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 30,
                  color: Color(0xff368983),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 30,
                  color: Color(0xff368983),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.exit_to_app,
                  size: 30,
                  color: Color(0xff368983),
                ),
              ),
            ],
          )),
    );
  }
}
