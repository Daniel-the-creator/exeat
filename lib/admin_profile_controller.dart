// In profile_controller.dart
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var fullName = 'Ilesanmi Daniel'.obs; // Sample data
  var email = 'danielilesanmi04@example.com'.obs;
  var phone = '+234 123 456 7890'.obs;

  // Add method to get first name or full name
  String getDisplayName() {
    return fullName.value.split(' ').first; // Returns first name
    // OR return fullName.value; // Returns full name
  }

  @override
  void onInit() {
    super.onInit();
    // Load user data from your database/API here
    loadUserProfile();
  }

  void loadUserProfile() {
    // TODO: Fetch from your database
    // Example:
    // fullName.value = fetchedData['fullName'];
    // email.value = fetchedData['email'];
    // etc.
  }
}
