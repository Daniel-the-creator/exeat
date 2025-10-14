import 'package:get/get.dart';

class ProfileController extends GetxController {
  var fullName = "Ilesanmi Daniel".obs;
  var email = "danielilesanmi04@gmail.com".obs;
  var phone = "+234 704 567 8882".obs;
  var matric = "DU0695".obs;

  void updateProfile({
    required String newName,
    required String newEmail,
    required String newPhone,
    required String newMatric,
  }) {
    fullName.value = newName;
    email.value = newEmail;
    phone.value = newPhone;
    matric.value = newMatric;
  }
}
