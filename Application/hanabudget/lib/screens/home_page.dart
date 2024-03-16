import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:hanabudget/screens/main_page.dart';

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
                  // If you have content that should go under the clipped area, it goes here.
                  // Otherwise, you can remove this part.
                ),
              ),
            ],
          ),
          const MainScreen(), // Positioned on top of the Column
        ],
      ),
    );
  }
}
