import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; // Get the screen size

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              width: size.width,
              height: size.height * 0.15, // Or any other fixed height as needed
              color: Color(0xFF1ED891),
              // Include here any widgets you would want at the top part, like a Row for a title or icons
            ),
          ),
          // The rest of your page content goes here
          Expanded(
            child: Container(
              // Your main page content starts here, after the custom app bar
              child: Center(
                child: Text("Content goes here"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
