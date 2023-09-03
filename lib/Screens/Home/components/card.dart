import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:soul_sync_app/utils/constants/color.dart';
import 'package:http/http.dart' as http;
import 'package:soul_sync_app/Model/userModel.dart';

class ExampleCard extends StatelessWidget {
  final bool isLiked;
  final Candidate candidate;
  final VoidCallback onLike;

  const ExampleCard(
      {required this.candidate, required this.onLike, required this.isLiked});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45.0),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(45.0),
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
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.98),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(candidate.firstName + ', ',
                                  style: kNameStyle),
                              Text(
                                '21',
                                style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white54),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Text('Grad. Yr: ', style: kHeadStyle),
                          //     Text(candidate.gradYear.toString(),
                          //         style: kLeadingStyle),
                          //   ],
                          // ),
                          SizedBox(height: 8),
                          //Text("About", style: kHeadStyle),
                          SizedBox(height: 8),
                          Text(
                            candidate.about ?? "aboutttt",
                            maxLines: 3,
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