import 'package:flutter/material.dart';

import '../../../utils/constants/color.dart';
class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
    GestureDetector(
      onTap: () {
        // Handle edit button action here
      },
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/confession');
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kGreyColor, // Customize the color as needed
          ),
          child: Icon(
            Icons.favorite_border,
            color: Colors.white, // Change icon color
          ),
        ),
      ),
    ),
    //SizedBox(width: 16), // Add some space between the edit button and the title
  ],
      );
  }

}

