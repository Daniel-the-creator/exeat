import 'package:exeat_system/editprofile.dart';
import 'package:exeat_system/home_page.dart';
import 'package:exeat_system/login_screen__student.dart';
import 'package:exeat_system/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
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
                      onTap: () => Get.to(() => const HomePage()),
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.black87, size: 22),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Profile Settings",
                      style: TextStyle(
                        color: const Color(0xff060121),
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeTitle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(paddingValue),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeText + 2,
                          color: const Color(0xff060121),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Reactive Info
                      Obx(() => Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildProfileDetail(
                                        "FULL NAME",
                                        controller.fullName.value,
                                        fontSizeText),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: _buildProfileDetail("EMAIL",
                                        controller.email.value, fontSizeText),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildProfileDetail("PHONE NUMBER",
                                        controller.phone.value, fontSizeText),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: _buildProfileDetail("MATRIC NUMBER",
                                        controller.matric.value, fontSizeText),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: () => Get.to(() => const EditProfile()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            side: const BorderSide(color: Colors.grey),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                          ),
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: fontSizeButton,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Account Settings Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(paddingValue),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account Settings",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeText + 2,
                          color: const Color(0xff060121),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                              fontSize: fontSizeButton,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () => Get.to(() => const LoginScreen()),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red.shade700,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeButton,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value, double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: fontSize - 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
