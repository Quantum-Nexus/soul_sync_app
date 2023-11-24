import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class customLoader extends StatefulWidget {
  const customLoader({super.key});

  @override
  State<customLoader> createState() => _customLoaderState();
}

class _customLoaderState extends State<customLoader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/images/loader.json',
        width: 300,
        height: 300,
      ),
    );
  }
}
