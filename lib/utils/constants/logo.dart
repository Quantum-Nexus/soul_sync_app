import 'package:flutter/material.dart';

import 'color.dart';


class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Column(
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Soul", style: kLogo1Style,),
                  Text("Sync", style: kLogo2Style,),
                ],
              ),
              SizedBox(height: 5,),
              Text("Syncing Hearts", style: kTagStyle),
              
            ],
          );
  }
}