// profile_controller.dart
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var fullName = 'Ilesanmi Daniel'.obs;
  var matric = 'DU0695'.obs;
  var department = 'Software engineering'.obs;
  var level = '400 Level'.obs;
  var email = 'danielilesanmi04@gmail.com'.obs;
  var phone = '+2347045678882'.obs;

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
