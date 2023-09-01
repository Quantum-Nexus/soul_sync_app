import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:soul_sync_app/Model/confession.dart';

class ConfessionController extends GetxController {
  var confessions = <Confession>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchConfessions();
  }

  void fetchConfessions() async {
    await Future.delayed(Duration(milliseconds: 1000));
    var confessionList = [
      Confession(
        confessionid: 1,
        confessiontxt: 'This is first confession, I love you with my whole heart.',
        date: '27/08/2023',
        upvotes: 0,
      ),
      Confession(
        confessionid: 2,
        confessiontxt: 'This is second confession, I love you with my whole heart.',
        date: '27/08/2023',
        upvotes: 0,
      ),
      Confession(
        confessionid: 3,
        confessiontxt: 'This is third confession, I love you with my whole heart.',
        date: '27/08/2023',
        upvotes: 0,
      ),
       Confession(
        confessionid: 4,
        confessiontxt: 'This is forth confession, I love you with my whole heart.',
        date: '27/08/2023',
        upvotes: 0,
      ),
    ];
    confessions.value = confessionList;
  }

  // Function to add a new confession
  void addConfession(String confessionText) {
    // Create a new confession instance with a unique ID
    final newConfession = Confession(
      confessionid: DateTime.now().millisecondsSinceEpoch, // Unique ID
      confessiontxt: confessionText,
      date: DateTime.now().toString(), // Current timestamp
    );

    // Add the new confession to the list of confessions
    confessions.insert(0, newConfession); // Insert at the beginning of the list

    // Notify listeners that the list has changed
    update();
  }
}
