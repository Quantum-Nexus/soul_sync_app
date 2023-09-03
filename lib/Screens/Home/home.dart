import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
  Candidate? currentCandidate;
  String? storedUserName;
  String? storedGender;
  bool allCardsSwiped = false;
  Future<List<Candidate>>? candidatesFuture = Future.value([]);
  bool isLoading = false;
  bool displaylike = false;
  bool displaycross = false;
  late Timer emoji;

  @override
  void initState() {
    super.initState();
    loadUserInfo();
    candidatesFuture = fetchCandidates();
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
    final prefs = await SharedPreferences.getInstance();
    final jwtToken = prefs.getString('jwt_token') ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Lottie.asset(
            'assets/images/loader.json',
            width: 300,
            height: 300,
          ),
        );
      },
      barrierDismissible: false,
    );

    final response = await http.get(
      Uri.parse('http://localhost:4000/api/v1/fetch/fetchallusers'),
      headers: {'Authorization': 'Bearer $jwtToken'},
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
      final List<dynamic> candidateData = json.decode(response.body);

      return candidateData.map((json) => Candidate.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch candidates');
    }
  }

  Future<void> fetchData() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final candidates = await fetchCandidates();

    setState(() {
      swipedProfiles.clear();
      candidatesFuture = Future.value(candidates);
      isLoading = false;
      allCardsSwiped = candidates.isEmpty;
    });
  }

  Widget displaycrossEmoji() {
    if (displaycross) {
      return Container(
        width: 150,
        //color: Colors.red,
        child: Lottie.asset('assets/images/dislike.json',
            //width: 100,
            fit: BoxFit.fitWidth // Replace with your Lottie animation file
            ),
      );
    } else {
      return Container(); // Return an empty container when display is false
    }
  }

  Widget displayHeartEmoji() {
    if (displaylike) {
      return Container(
        width: 200,
        //height: 500,
        child: Lottie.asset(
          'assets/images/like2.json',
        ),
      );
    } else {
      return Container(); // Return an empty container when display is false
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: MyAppBar(),
      ),
      backgroundColor: kPrimaryColor,
      drawer: AppDrawer(),
      body: Stack(
        children: [
          Column(
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
                    ),
                    Text(
                      "Here's your swipe list for today.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: FutureBuilder<List<Candidate>>(
                  future: candidatesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError || snapshot.data == null) {
                      // Check if data is null
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data!.isEmpty) {
                      // Check if data is empty
                      return Center(child: Text('No candidates available.', style: TextStyle(color: Colors.white),));
                    } else {
                      final List<Candidate> candidates = snapshot
                          .data!; // Use the non-null assertion operator (!)
                      int cardlength = candidates.length;
                      return CardSwiper(
                        controller: _controller,
                        cardsCount: cardlength,
                        maxAngle: 60,
                        initialIndex: 0,
                        allowedSwipeDirection:
                            AllowedSwipeDirection.only(left: true, right: true),
                        onSwipe: (previousIndex, currentIndex, direction) {
                          //final candidate = snapshot.data![currentIndex!];
                          final candidate = snapshot.data![previousIndex!];
                          if (direction == CardSwiperDirection.right) {
                            
                            sendID(candidate);
                            print("Swiped right");
                            setState(() {
                              displaylike = true;
                            });

                            emoji = Timer(Duration(milliseconds: 1000), () {
                              setState(() {
                                displaylike = false;
                              });
                            });
                          } else {
                            print("Swiped Left");
                            setState(() {
                              displaycross = true;
                            });

                            emoji = Timer(Duration(milliseconds: 1000), () {
                              setState(() {
                                displaycross = false;
                              });
                            });
                          }

                          return true;
                        },
                        onUndo: (previousIndex, currentIndex, direction) {
                          print("swiped left");
                          return true;
                        },
                        onEnd: () {
                          fetchData();
                        },
                        numberOfCardsDisplayed: (cardlength > 1) ? 2 : 1,
                        padding: const EdgeInsets.all(16.0),
                        cardBuilder: (
                          context,
                          index,
                          horizontalThresholdPercentage,
                          verticalThresholdPercentage,
                        ) {
                          final candidate = snapshot.data![index];
                          if (swipedProfiles.contains(candidate.id)) {
                            return Container();
                          }
                          return ExampleCard(
                            isLiked: _isLiked,
                            candidate: candidate,
                            onLike: () => sendID(candidate),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.centerLeft, child: displaycrossEmoji()),
              SizedBox(
                width: 10,
              ),
              Align(
                  alignment: Alignment.centerRight, child: displayHeartEmoji()),
            ],
          ),
        ],
      ),
    );
  }
}
