import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sync_app/utils/constants/color.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CardSwiperController _controller = CardSwiperController();
  int _selectedIndex = 0;

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt_token');
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Future<List<Candidate>> fetchCandidates() async {
    final response = await http.get(Uri.parse('http://localhost:4000/api/v1/fetch/fetchallusers'));

    if (response.statusCode == 200) {
      final List<dynamic> candidateData = json.decode(response.body);

      return candidateData.map((json) => Candidate.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch candidates');
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "SOUL SYNC",
          style: kLogoStyle,
        ),
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            logout();
          },
          child: Icon(Icons.logout),
        ),
      ),
      backgroundColor: Color(0xff1a1f2b),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Stack(
                children:[ 
                  Center(child: CircularProgressIndicator()),
                  FutureBuilder<List<Candidate>>(
                  future: fetchCandidates(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No candidates available.');
                    } else {
                      return CardSwiper(
                        controller: _controller,
                        cardsCount: snapshot.data!.length,
                        onSwipe: (previousIndex, currentIndex, direction) {
                          // Handle card swiping logic
                          return true;
                        },
                        onUndo: (previousIndex, currentIndex, direction) {
                          // Handle card undo logic
                          return true;
                        },
                        numberOfCardsDisplayed: 2,
                        padding: const EdgeInsets.all(16.0),
                        cardBuilder: (
                          context,
                          index,
                          horizontalThresholdPercentage,
                          verticalThresholdPercentage,
                        ) =>
                            ExampleCard(candidate: snapshot.data![index]),
                      );
                    }
                  },
                ),
                ]
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite),
      //       label: 'Favorites',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.blue,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}

class Candidate {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? about;
  final int? gradYear;
  final String imageUrl;

  Candidate({
    required this.gradYear,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
    required this.about
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imageUrl: json['image'], 
      gradYear: json['graduationYear'],
      about: json['about'],
    );
  }
}

class ExampleCard extends StatelessWidget {

  final Candidate candidate;

  const ExampleCard({required this.candidate});

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height*0.7,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  candidate.imageUrl,
                  height: MediaQuery.of(context).size.height * 0.7,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.9),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                candidate.firstName + ', ' ,
                                style: kNameStyle
                              ),
                              Text(
                                '21' ,
                                style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white54
                                ),
                              ),
                            ],
                          ),
                          //SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Grad. Yr: ',
                                style: kHeadStyle
                              ),
                              Text(
                                candidate.gradYear.toString(),
                                style: kLeadingStyle
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          Text(
                            "About",
                            style: kHeadStyle,
                          ),
                          SizedBox(height: 8,),
                          Text(
                            candidate.about ?? "aboutttt",
                            maxLines: 3, // Show only the first 3 lines
                            overflow: TextOverflow.ellipsis,
                            style: kAboutStyle,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
