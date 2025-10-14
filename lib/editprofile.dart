import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exeat_system/profile_controller.dart';
import 'package:exeat_system/profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final controller = Get.find<ProfileController>();

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController matricController;

  @override
  void initState() {
    super.initState();
    // Initialize text fields with current values from controller
    fullNameController = TextEditingController(text: controller.fullName.value);
    emailController = TextEditingController(text: controller.email.value);
    phoneController = TextEditingController(text: controller.phone.value);
    matricController = TextEditingController(text: controller.matric.value);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    matricController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double containerWidth =
        screenWidth < 600 ? screenWidth * 0.9 : screenWidth * 0.5;
    double fontSizeTitle = screenWidth < 600 ? 22 : 28;
    double fontSizeText = screenWidth < 600 ? 14 : 16;
    double fontSizeButton = screenWidth < 600 ? 14 : 18;
    double paddingValue = screenWidth < 600 ? 12 : 20;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: containerWidth,
            padding: EdgeInsets.all(paddingValue),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => const Profile()),
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.black87, size: 22),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Edit Profile",
                      style: TextStyle(
                        color: const Color(0xff060121),
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeTitle,
                      ),
                    ),
                  ],
                ),
                _buildTextField("Full Name", fullNameController, fontSizeText),
                const SizedBox(height: 15),
                _buildTextField("Email", emailController, fontSizeText),
                const SizedBox(height: 15),
                _buildTextField("Phone Number", phoneController, fontSizeText),
                const SizedBox(height: 15),
                _buildTextField(
                    "Matric Number", matricController, fontSizeText),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff060121),
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingValue * 2,
                        vertical: paddingValue * 0.7,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Save Changes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSizeButton,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize - 1,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  void _saveProfile() {
    // Update the controller values
    controller.fullName.value = fullNameController.text;
    controller.email.value = emailController.text;
    controller.phone.value = phoneController.text;
    controller.matric.value = matricController.text;

    // Optionally show a success message
    Get.snackbar(
      "Profile Updated",
      "Your profile information has been saved successfully.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
    );

    // Navigate back to Profile screen
    Get.off(() => const Profile());
  }
}
