import 'package:exeat_system/admin_dashboard.dart';
import 'package:exeat_system/forgot_password.dart';
import 'package:exeat_system/login_screen__student.dart';
import 'package:exeat_system/signup_staff.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginscreenStaff extends StatefulWidget {
  const LoginscreenStaff({super.key});

  @override
  State<LoginscreenStaff> createState() => _LoginscreenStaffState();
}

class _LoginscreenStaffState extends State<LoginscreenStaff> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double containerWidth =
        screenWidth < 600 ? screenWidth * 0.9 : screenWidth * 0.4;
    double fontSizeTitle = screenWidth < 600 ? 24 : 32;
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "WELCOME!!",
                  style: TextStyle(
                    color: const Color(0xff060121),
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeTitle,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: paddingValue * 1.2,
                          vertical: paddingValue * 0.6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey,
                        ),
                        child: Text(
                          "Student",
                          style: TextStyle(
                            color: const Color(0xff060121),
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeButton,
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(() => const LoginScreen());
                      },
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingValue * 1.5,
                        vertical: paddingValue * 0.6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xff060121),
                      ),
                      child: Text(
                        "Admin",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeButton,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      hintText: 'Email',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey[700],
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff060121)),
                    padding: EdgeInsets.symmetric(
                        horizontal: paddingValue * 1.2,
                        vertical: paddingValue * 0.8),
                    child: Center(
                      child: Text(
                        "LOG IN",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeButton),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.to(() => const AdminDashboard());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(fontSize: fontSizeButton),
                    ),
                    onTap: () {
                      Get.to(() => const ForgotPassword());
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "don't have an account? Sign Up",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: fontSizeButton),
                    ),
                    onTap: () {
                      Get.to(() => const SignupStaff());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
