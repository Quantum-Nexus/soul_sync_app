import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:soul_sync_app/Model/confession.dart';

class ConfessionController extends GetxController {
  var confessions = <Confession>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchConfessions();
  }

  Future<void> fetchConfessions() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:4000/api/v1/allconfession'));
      // response.body.trim();
      
      // if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<Confession> confessionList =
            (data as List).map((item) => Confession.fromJson(item)).toList();
        //t;o update the observable list
        
        confessionList.assignAll(confessionList);
      // } else {
      //   throw Exception('Failed to load confessions');
      // }
    } catch (e) {
      // Handle errors
    print('Error fetching confessions: $e');
    }
  }

  // void fetchConfessions() async {
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   var confessionList = [
  //     Confession(
  //       confessionid: 1,
  //       confessiontxt: 'This is first confession, I love you with my whole heart.',
  //       date: '27/08/2023',
  //       upvotes: 0,
  //     ),
  //     Confession(
  //       confessionid: 2,
  //       confessiontxt: 'This is second confession, I love you with my whole heart.',
  //       date: '27/08/2023',
  //       upvotes: 0,
  //     ),
  //     Confession(
  //       confessionid: 3,
  //       confessiontxt: 'This is third confession, I love you with my whole heart.',
  //       date: '27/08/2023',
  //       upvotes: 0,
  //     ),
  //      Confession(
  //       confessionid: 4,
  //       confessiontxt: 'This is forth confession, I love you with my whole heart.',
  //       date: '27/08/2023',
  //       upvotes: 0,
  //     ),
  //   ];
  //   confessions.value = confessionList;
  // }

  // Function to add a new confession
  void addConfession(String confessionText) {
    // Create a new confession instance with a unique ID
    final newConfession = Confession(
      confessionid: DateTime.now().millisecondsSinceEpoch, // Unique ID
      confessiontxt: confessionText,
      date: DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(), // Current timestamp
    );

    // Add the new confession to the list of confessions
    confessions.insert(0, newConfession); // Insert at the beginning of the list

    // Notify listeners that the list has changed
    update();
  }
}
