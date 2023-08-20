import 'dart:convert';

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
        leading: GestureDetector(
          onTap: () {
            logout();
          },
          child: Icon(Icons.logout),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: FutureBuilder<List<Candidate>>(
                future: fetchCandidates(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loading indicator
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
                      numberOfCardsDisplayed: 1,
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Candidate {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;

  Candidate({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imageUrl: json['image'],
    );
  }
}

class ExampleCard extends StatelessWidget {
  final Candidate candidate;

  const ExampleCard({required this.candidate});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Image.network(candidate.imageUrl), // Use Image.network to load image from URL
          Text(candidate.firstName + ' ' + candidate.lastName),
          Text(candidate.email),
        ],
      ),
    );
  }
}
