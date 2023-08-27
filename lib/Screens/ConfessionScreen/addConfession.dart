import 'package:flutter/material.dart';

class ConfessionSubmissionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Confession'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your confession...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement submission logic here
                // You can save the confession locally or send it to a backend
                // Provide user feedback on success or failure
              },
              child: Text('Submit Confession'),
            ),
          ],
        ),
      ),
    );
  }
}
