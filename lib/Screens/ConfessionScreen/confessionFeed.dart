import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sync_app/Model/confession.dart';
import 'package:soul_sync_app/utils/constants/color.dart';
import 'package:soul_sync_app/utils/constants/loader.dart';

class ConfessionFeedScreen extends StatefulWidget {
  @override
  State<ConfessionFeedScreen> createState() => _ConfessionFeedScreenState();
}

class _ConfessionFeedScreenState extends State<ConfessionFeedScreen> {
  List<Confession> confessions = [];

  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> submitConfession(String confessionText) async {
    final prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? '';
    String token = prefs.getString('jwt_token') ?? '';
    print(userId);
    print(confessionText);
    String _errorText = '';
    //final url = 'http://localhost:4000/api/v1/addconfession'; // Replace with your API endpoint

    final Map<String, String> headers = {
  'Content-Type': 'application/json', // Check if this is the correct content type
  // Add any other headers if required
};

final Map<String, dynamic> requestBody = {
  'message': confessionText,
  'userId': userId,
  'token': token
};

try {
  final response = await http.post(
    Uri.parse('http://localhost:4000/api/v1/addconfession'),
    headers: headers,
    body: jsonEncode(requestBody),
  );
  print('Response Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');
  if (response.statusCode == 201) {
    // Confession submitted successfully
    _textController.clear();
    setState(() {
      fetchConfessions();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Confession added Successfully"),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Confession not sent"),
      ),
    );
  }
} catch (error) {
  // Handle network errors
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error.toString()),
    ),
  );
}

  }

  Future<List<Confession>> fetchConfessions() async {
    final url =
        'http://localhost:4000/api/v1/allconfession'; // Replace with your API endpoint
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((confession) => Confession.fromJson(confession)).toList();
    } else {
      throw Exception('Failed to load confessions');
    }
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
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Submit"),
              onPressed: () {
                String confessiontxt = _textController.text.trim();
                submitConfession(confessiontxt);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        margin: const EdgeInsets.only(left: 20,right: 20, top: 50 //vertical: 50
        ),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Your ',
                style: TextStyle(
                  fontSize: height * 0.042,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryLightColor,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: 'secrets ',
                    style: TextStyle(
                      fontSize: height * 0.042,
                      fontWeight: FontWeight.bold,
                      color: kPinkColor,
                    ),
                  ),
                  TextSpan(
                    text: 'are safe with us!',
                    style: TextStyle(
                      fontSize: height * 0.042,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryLightColor,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Send your anonymous confessions',
              style: TextStyle(
                  color: kPrimaryLightColor, fontSize: height * 0.018),
            ),
            Expanded(
              child: FutureBuilder<List<Confession>>(
                future: fetchConfessions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return customLoader();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Confession> confessions = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: confessions.length,
                      itemBuilder: (context, index) {
                            final confession = confessions[index];
      final date = DateTime.parse(confession.date); // Assuming date is in ISO 8601 format

      String formattedDate;
      final now = DateTime.now();
      final difference = now.difference(date);
      if (difference.inDays >= 1) {
        final daysAgo = difference.inDays;
        formattedDate = '$daysAgo ${daysAgo == 1 ? 'day' : 'days'} ago';
      } else if (difference.inHours >= 1) {
        formattedDate = '${difference.inHours} hours ago';
      } else {
        formattedDate = '${difference.inMinutes} minutes ago';
      }
                        return Card(
                          color: index.isEven ? kPinkColor : kYellowColor,
                          margin: EdgeInsets.symmetric(vertical: 12.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${confessions[index].confessiontxt}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: index.isEven
                                        ? kPrimaryLightColor
                                        : kPrimaryColor,
                                  ),
                                ),
                                Divider(
                                  color: index.isEven
                                      ? kPrimaryLightColor
                                      : kPrimaryColor,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formattedDate,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: index.isEven
                                            ? kPrimaryLightColor
                                            : kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        tooltip: "Write a confession",
        isExtended: true,
        backgroundColor: kPrimaryLightColor,
        onPressed: () {
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
