// profile_controller.dart
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var fullName = 'Student Name'.obs;
  var matric = 'MAT12345'.obs;
  var department = 'Computer Science'.obs;
  var level = '400 Level'.obs;
  var email = 'student@university.edu.ng'.obs;
  var phone = '+2348012345678'.obs;

  void updateProfile({
    required String newName,
    required String newMatric,
    required String newDept,
    required String newLevel,
    required String newEmail,
    required String newPhone,
  }) {
    fullName.value = newName;
    matric.value = newMatric;
    department.value = newDept;
    level.value = newLevel;
    email.value = newEmail;
    phone.value = newPhone;
  }
}
