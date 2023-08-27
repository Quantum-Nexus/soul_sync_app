import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sync_app/Model/userModel.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  Future<Map<String, dynamic>> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final jwtToken = prefs.getString('jwt_token') ?? '';

    if (jwtToken.isEmpty) {
      // Handle the case where JWT token is not available
      return {}; // Return an empty map or handle it differently
    }

    final url = 'http://localhost:4000/api/v1/myprofile';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': jwtToken}),
    );

    print('Response status code: ${response.statusCode}');
    final responseBody = json.decode(response.body);
    print(responseBody);
    final user = responseBody['user'];
    final image = user['image']; // Access the image field
    final firstname = user['firstName']; 
    final lastname = user['lastName'];
    final gender = user['gender'];// Access the username field
    final about = user['about'];
    final dob = user['dateOfBirth'];
    final number = user['contactNumber'];
    final height = user['height'];
    final insta = user['instagramUsername'];
    final year = user['graduationYear'];
    final email = user['email'];
    return {
      'image': image, 
      'firstname': firstname, 
      'lastname': lastname,
      'gender': gender,
      'about': about,
      'dateOfBirth' : dob,
      'contactNumber' : number,
      'height' : height,
      'instagramUsername' : insta,
      'graduationYear' : year,
      'email' : email
      };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/home');},
 // Navigate back when the button is pressed
    
    child: Padding(
      padding: const EdgeInsets.only(left:8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kGreyColor, // Customize the color as needed
        ),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white, // Change icon color
        ),
      ),
    ),
  ),
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
    GestureDetector(
      onTap: () {
        // Handle edit button action here
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kPrimaryColor, // Customize the color as needed
        ),
        child: Icon(
          Icons.edit,
          color: Colors.white, // Change icon color
        ),
      ),
    ),
    SizedBox(width: 16), // Add some space between the edit button and the title
  ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('Data not available.');
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9999,
                        //height: 300,
                        decoration: BoxDecoration(
                            color: kGreyColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            SizedBox(height: 35),
                            Container(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  snapshot.data!['image'], // Use the image URL here
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data!['firstname'],
                                  style: kAboutStyle,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  snapshot.data!['lastname'],
                                  style: kAboutStyle,
                                ),
                              ]
                            ),
            
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "21",
                                  //snapshot.data!['firstname'],
                                  style: kAboutStyle,
                                ),
                                Text("  |  ",style: TextStyle(color: Colors.white,fontSize: 26),),
                                Text(
                                  snapshot.data!['gender'],
                                  style: kAboutStyle,
                                ),
                              ]
                            ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Text(
                                    snapshot.data!['about'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16,color: Colors.grey,),
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.9999,
                          //height: 300,
                          decoration: BoxDecoration(
                              color: kGreyColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 25),
                            
                                Text("Graduation Year",
                                style: kDetailHeadStyle,),
                                Text(snapshot.data!['graduationYear'].toString(),
                                style: kDetailStyle,
                                ),
                          
                                SizedBox(height: 10,),
                                Text("Height",
                                style: kDetailHeadStyle,),
                                Text(snapshot.data!['height'].toString(),
                                style: kDetailStyle,),
                          
                                SizedBox(height: 10,),
                                Text("Date Of Birth",
                                style: kDetailHeadStyle,),
                                Text(snapshot.data!['dateOfBirth'].toString(),
                                style: kDetailStyle,),
                          
                                SizedBox(height: 10,),
                                Text("Instagram Username",
                                style: kDetailHeadStyle,),
                                Text(snapshot.data!['instagramUsername'],
                                style: kDetailStyle,),
                          
                                SizedBox(height: 10,),
                                Text("Contact Number",
                                style: kDetailHeadStyle,),
                                Text(snapshot.data!['contactNumber'].toString(),
                                style: kDetailStyle,),
                          
                                SizedBox(height: 10,),
                                Text("Email",
                                style: kDetailHeadStyle,),
                                Text(snapshot.data!['email'],
                                style: kDetailStyle,),
                                SizedBox(height: 40,)
                              ],
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
