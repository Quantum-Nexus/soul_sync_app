import 'package:flutter/material.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  bool isPressed = false;

  void _toggleButtonState() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
          margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: ,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: height * 0.240,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 239, 238, 238),
                        borderRadius: BorderRadius.circular(height * 0.012),
                      ),
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 105, 105, 105),
                          size: height * 0.060,
                        ),
                        Text(
                          "Add a Image",
                          style: TextStyle(
                              color: Color.fromARGB(255, 105, 105, 105),
                              fontSize: height * 0.024),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: height * 0.300,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: kBrightColor)),
                child: Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    
                  ],
                )),
              ),
              GestureDetector(
                onTap: () {
                  _toggleButtonState();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.060,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isPressed ? Colors.white : kBrightColor,
                    border: Border.all(
                        color: isPressed ? kBrightColor : Colors.transparent,
                        width: 1),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        color: isPressed ? kBrightColor : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
