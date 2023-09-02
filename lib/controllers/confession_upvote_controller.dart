import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:soul_sync_app/Model/confession.dart';

import 'confession_controller.dart';

class ConfessionUpvoteController extends GetxController {
  var controller = Get.put(ConfessionController());
   // Method to upvote a confession
  void upvoteConfession(Confession confession) {
    confession.upvotes++; // Increment the upvotes for the confession
  }
  // Method to calculate total upvotes for a confession
  int calculateTotalUpvotes(Confession confession) {
    return confession.upvotes;
  }


}
