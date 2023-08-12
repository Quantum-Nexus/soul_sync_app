import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {

  Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('jwt_token');
  Navigator.of(context).pushReplacementNamed('/login');
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            logout();
          },
          child: Icon(Icons.logout)),
      ),
      backgroundColor: kBackgroundColor,
      body: const Center(
        child: Text("homeScreen"),
      ),
    );
  }
}