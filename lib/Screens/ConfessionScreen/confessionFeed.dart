import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sync_app/controllers/confession_controller.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

import '../../controllers/confession_upvote_controller.dart';

class ConfessionFeedScreen extends StatefulWidget {
  @override
  State<ConfessionFeedScreen> createState() => _ConfessionFeedScreenState();
}

class _ConfessionFeedScreenState extends State<ConfessionFeedScreen> {
  final confessionController = Get.put(ConfessionController());

  final upvoteController = Get.put(ConfessionUpvoteController());

  // Create a TextEditingController
  final TextEditingController _textController = TextEditingController();


  bool _isSubmitting = false; // Track whether a submission is in progress.

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
Future<void> _showConfessionDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Write a Confession"),
        content: TextField(
          maxLines: 5,
          controller: _textController,
          decoration: InputDecoration(
            hintText: "Type your confession here",
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                color: kPinkColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              "Submit",
              style: TextStyle(
                color: kPinkColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () async {
              String confessiontxt = _textController.text;
              await _submitConfession(confessiontxt);
            },
          ),
        ],
      );
    },
  );
}
  // Future<void> _showConfessionDialog(BuildContext context) async {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Write a Confession"),
  //         content: TextField(
  //           maxLines: 5,
  //           controller: _textController,
  //           decoration: InputDecoration(
  //             hintText: "Type your confession here",
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text(
  //               "Cancel",
  //               style: TextStyle(
  //                 color: kPinkColor,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text(
  //               "Submit",
  //               style: TextStyle(
  //                 color: kPinkColor,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             onPressed: _isSubmitting
  //                 ? null // Disable the button when submitting.
  //                 : () async {
  //                     String confessiontxt = _textController.text;
  //                     await _submitConfession(confessiontxt);
  //                   },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<void> _submitConfession(String confessionText) async {
    final prefs = await SharedPreferences.getInstance();
    final jwtToken = prefs.getString('jwt_token') ?? '';
    setState(() {
      _isSubmitting = true; // Start the submission, disable the button.
    });

    try {
      debugPrint(jwtToken);
      final response = await http.post(Uri.parse('http://localhost:4000/api/v1/addconfession'),
        body: json.encode({'message': confessionText}),
        headers: {'Content-type':'application/json','Authorization': 'Bearer $jwtToken'},
      );

      debugPrint(response.body);
      // if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Confession submitted successfully.'),
          ),
        );

        _textController.clear();
        confessionController.fetchConfessions();
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content:
      //           Text('Failed to submit confession. Please try again later.'),
      //     ),
      //   );
      // }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
        _textController.clear();
        Navigator.pop(context); // Submission completed, enable the button.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        // height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                  text: 'Your ',
                  style: GoogleFonts.urbanist(
                    fontSize: height * 0.042,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryLightColor,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'secrets ',
                      style: GoogleFonts.urbanist(
                        // height: 2,
                        fontSize: height * 0.042,
                        fontWeight: FontWeight.bold,
                        color: kPinkColor,
                      ),
                    ),
                    TextSpan(
                      text: 'are safe with us!',
                      style: GoogleFonts.urbanist(
                        fontSize: height * 0.042,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryLightColor,
                      ),
                    ),
                  ]),
            ),
            Text(
              'Send your anonymous confessions',
              style: TextStyle(
                  color: kPrimaryLightColor, fontSize: height * 0.018),
            ),
            Expanded(child: GetX<ConfessionController>(builder: (controller) {
              debugPrint((controller.confessions.length).toString());
              return ListView.builder(
                  itemCount: controller.confessions.length,
                 
                  itemBuilder: (context, index) {
                    return Card(
                      color: index.isEven ? kPinkColor : kYellowColor,
                      margin: EdgeInsets.symmetric(vertical: 12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.confessions[index].confessiontxt}',
                              style: TextStyle(
                                fontSize: 20,
                                color: index.isEven
                                    ? kPrimaryLightColor
                                    : kPrimaryColor,
                              ),
                            ),
                            Divider(
                              // indent: width*0.05,
                              // endIndent: width*0.05,
                              color: index.isEven
                                  ? kPrimaryLightColor
                                  : kPrimaryColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${controller.confessions[index].date}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: index.isEven
                                        ? kPrimaryLightColor
                                        : kPrimaryColor,
                                  ),
                                ),
                                GetX<ConfessionUpvoteController>(
                                    builder: (upvoteController) {
                                  String upvotesForConfession = upvoteController
                                      .calculateTotalUpvotes(
                                          controller.confessions[index])
                                      .toString();
                                  return Row(
                                    children: [
                                      Text(
                                        '$upvotesForConfession',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: index.isEven
                                              ? kPrimaryLightColor
                                              : kPrimaryColor,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.arrow_upward_outlined),
                                        color: index.isEven
                                            ? kPrimaryLightColor
                                            : kPrimaryColor,
                                        onPressed: () {
                                          // Increment the upvote count
                                          upvoteController.upvoteConfession(
                                              controller.confessions[index]);

                                          // Trigger immediate UI update
                                          controller.update();
                                        },
                                      ),
                                    ],
                                  );
                                })
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        tooltip: "Write a confession",
        isExtended: true,
        backgroundColor: kPrimaryLightColor,
        onPressed: () {
          // Call the function to show the pop-up dialog
          _showConfessionDialog(context);
        },
        child: const Icon(
          Icons.favorite,
          color: kPinkColor,
          size: 30,
        ),
      ),
    );
  }
}
