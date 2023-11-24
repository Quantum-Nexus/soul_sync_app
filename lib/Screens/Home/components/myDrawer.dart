import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sync_app/utils/constants/color.dart';
import 'package:soul_sync_app/utils/constants/logo.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String? firstName;
  String? lastName;

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  void loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('first_name');
      lastName = prefs.getString('last_name');
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt_token');
    prefs.remove('gender');
    prefs.remove('first_name');
    prefs.remove('last_name');

    Navigator.of(context).pushReplacementNamed('/login');
  }

  // Future<String> fetchUserName() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final jwtToken = prefs.getString('jwt_token') ?? '';

  //   if (jwtToken.isEmpty) {
  //     // Handle the case where JWT token is not available
  //     return ''; // Return an empty string or handle it differently
  //   }

  //   final url = 'http://localhost:4000/api/v1/myprofile';

  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'token': jwtToken}),
  //   );

  //   print('Response status code: ${response.statusCode}');
  //   final responseBody = json.decode(response.body);
  //   print(responseBody);
  //   final user = responseBody['user'];
  //   final userName = user['firstName']; // Access the 'firstName' field
  //   return userName;
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 300,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Soul",
                          style: GoogleFonts.leagueSpartan(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: kYellowColor)),
                      Text(
                        "Sync",
                        style: GoogleFonts.leagueSpartan(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: kPinkColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            firstName ?? "Guest",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            " ${lastName}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/profile');
                      },
                      child: Text(
                        "View Profile",
                        style: GoogleFonts.quicksand(
                            fontSize: 15,
                            letterSpacing: 4,
                            fontWeight: FontWeight.w600,
                            color: Colors.white54),
                      ))
                ],
              ),
            ),
          ),
          SizedBox(height: 100,),
          ListTile(
            leading: Icon(
              Icons.home,
              color: kPinkColor,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Handle drawer item tap for home
              Navigator.pop(context); // Close the drawer
              // Navigate to the home screen or perform other actions
            },
          ),
          ListTile(
            leading: Icon(
              Icons.voice_chat,
              color: kPinkColor,
            ),
            title: Text(
              'Confession',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Handle drawer item tap for settings
               // Close the drawer
              Navigator.pushReplacementNamed(context, '/confession');
              // Navigate to the settings screen or perform other actions
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: kPinkColor,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Handle drawer item tap for settings
              logout(); // Close the drawer
              // Navigate to the settings screen or perform other actions
            },
          ),
          // Add more list tiles for other drawer items
        ],
      ),
    );
  }
}
