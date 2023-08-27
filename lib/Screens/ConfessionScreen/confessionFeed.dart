import 'package:flutter/material.dart';

class ConfessionFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace with actual data retrieval logic
    List<String> confessions = [
      'Confession 1',
      'Confession 2',
      'Confession 3',
      // ...
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Confession Feed'),
      ),
      body: ListView.builder(
        itemCount: confessions.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(confessions[index]),
              // You can display timestamp or other information here
            ),
          );
        },
      ),
    );
  }
}
