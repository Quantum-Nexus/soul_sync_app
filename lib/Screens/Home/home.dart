import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sync_app/Screens/Home/components/appBar.dart';
import 'package:soul_sync_app/Screens/Home/components/myDrawer.dart';
import 'package:soul_sync_app/utils/constants/color.dart';
import 'package:http/http.dart' as http;

import '../../Model/userModel.dart';
import 'components/card.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? storedUserName;
  String? storedGender;

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  void loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      storedUserName = prefs.getString('first_name');
      storedGender = prefs.getString('gender');
    });
  }

  final CardSwiperController _controller = CardSwiperController();
  int _selectedIndex = 0;
  Set<String> swipedProfiles = Set<String>();
  bool _isLiked = false;
  Candidate? _currentCandidate;

  void sendID(Candidate candidate) async {
    final prefs = await SharedPreferences.getInstance();
    final jwtToken = prefs.getString('jwt_token') ?? '';

    if (jwtToken.isEmpty) {
      // Handle the case where JWT token is not available
      // You might want to redirect to the login screen or handle it differently
      print('JWT token is missing');
      return;
    }

    print('Bearer $jwtToken');
    if (candidate.email != null) {
      const url =
          'http://localhost:4000/api/v1/fetch/addconnection'; // Replace with your actual API endpoint

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'otheremail': candidate.email,
          'my_token': 'Bearer $jwtToken',
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final jwtToken = responseBody['token'];

        print(responseBody);

        // Store the JWT token securely
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('jwt_token', jwtToken);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Home()));
      } else {
        final responseBody = json.decode(response.body);
        if (responseBody.containsKey('message')) {
          final errorMessage = responseBody['message'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      }
    }
  }

  Future<List<Candidate>> fetchCandidates() async {
    final response = await http
        .get(Uri.parse('http://localhost:4000/api/v1/fetch/fetchallusers'));

    if (response.statusCode == 200) {
      final List<dynamic> candidateData = json.decode(response.body);

      return candidateData.map((json) => Candidate.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch candidates');
    }
  }

  List<Candidate> filterCandidatesByGender(
      List<Candidate> candidates, String userGender) {
    // Navigator.pop(context);
    if (userGender == 'Male') {
      return candidates
          .where((candidate) => candidate.gender == 'Female')
          .toList();
    } else if (userGender == 'Female') {
      return candidates
          .where((candidate) => candidate.gender == 'Male')
          .toList();
    } else {
      return candidates;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: MyAppBar()),
      backgroundColor: kPrimaryColor,
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, " + (storedUserName ?? "Guest") + "👋",
                  style: kWelcomeStyle,
                ), // Display username or "Guest" if not available
                Text(
                  "Here's your swipe list for today.",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Flexible(
            child: Stack(
              children: [
                //Center(child: CircularProgressIndicator()),
                FutureBuilder<List<Candidate>>(
                  future: fetchCandidates(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No candidates available.'));
                    } else {
                      final filteredCandidates = filterCandidatesByGender(
                          snapshot.data!, storedGender ?? "");

                      if (filteredCandidates.isEmpty) {
                        return Center(
                          child: Text(
                            'No more swipes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      return CardSwiper(
                        controller: _controller,
                        cardsCount: snapshot.data!.length,
                        maxAngle: 60,
                        isLoop: false,
                        allowedSwipeDirection:
                            AllowedSwipeDirection.only(left: true, right: true),
                        onSwipe: (previousIndex, currentIndex, direction) {
                          final candidate = snapshot.data![currentIndex!];
                          if (direction == CardSwiperDirection.right) {
                            print("Swiped right");
                            sendID(candidate);
                          } else {
                            print("Swiped Left");
                          }

                          return true;
                        },
                        onUndo: (previousIndex, currentIndex, direction) {
                          // Handle card undo logic
                          print("swiped left");
                          return true;
                        },
                        
                        numberOfCardsDisplayed: 2,
                        padding: const EdgeInsets.all(16.0),
                        cardBuilder: (
                          context,
                          index,
                          horizontalThresholdPercentage,
                          verticalThresholdPercentage,
                        ) {
                          if (index >= filteredCandidates.length) {
                            print("no swipessssssss");
                            return Center(
                              child: Text(
                                'No swipessssssssss',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else {
                            final candidate = filteredCandidates[index];
                            if (swipedProfiles.contains(candidate.id)) {
                              return Container(); // Skip this profile if it's already swiped
                            }
                            return ExampleCard(
                              isLiked: _isLiked,
                              candidate: candidate,
                              onLike: () => sendID(candidate),
                            );
                          }
                          //else {
                          //   return Container();
                          //   //Navigator.pop(context);
                          //   return Center(
                          //     child: Text(
                          //       'No more swipes',
                          //       style: TextStyle(
                          //         fontSize: 18,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   );
                          // }
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
              height:
                  16), // Add spacing between the card swiper and like button
          // IconButton(
          //   onPressed: () {

          //       sendID(_currentCandidate!); // Send the selected candidate
          //       setState(() {
          //         _isLiked = !_isLiked; // Toggle the like status
          //       });

          //   },
          //   icon: Icon(
          //     _isLiked ? Icons.favorite : Icons.favorite_border,
          //   ),
          //   color: _isLiked
          //       ? Colors.red
          //       : Colors.grey, // Change colors based on like status
          //   iconSize: 40, // Adjust icon size as needed
          // ),
        ],
      ),
    );
  }
}
