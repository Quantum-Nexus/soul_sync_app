import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sync_app/Model/userModel.dart';
import 'package:http/http.dart' as http;

class CandidateProvider extends ChangeNotifier {
  List<Candidate> _candidates = [];

  List<Candidate> get candidates => _candidates;

  Future<List<Candidate>> fetchAndSetCandidates(bool shouldFetch) async {
  if (shouldFetch) {
    final prefs = await SharedPreferences.getInstance();
    final jwtToken = prefs.getString('jwt_token') ?? '';

    if (jwtToken.isEmpty) {
      print('JWT token is missing');
      return [];
    }

    final response = await http.get(
      Uri.parse('http://localhost:4000/api/v1/fetch/fetchallusers'),
      headers: {'Authorization': 'Bearer $jwtToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> candidateData = json.decode(response.body);
      final candidates = candidateData.map((json) => Candidate.fromJson(json)).toList();

      _candidates = candidates;
      notifyListeners();
      
      return candidates;
    } else {
      throw Exception('Failed to fetch candidates');
    }
  } else {
    return candidates; // Return candidates from provider's state
  }
}

}
