import 'package:exeat_system/login_screen__student.dart';
import 'package:exeat_system/request_admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import your controllers - make sure these files exist
import 'package:exeat_system/profile_controller.dart';
import 'package:exeat_system/request_controller.dart';

void main() {
  // Initialize controllers before running the app
  Get.put<ProfileController>(ProfileController());
  Get.put<RequestController>(RequestController());
  Get.put<RequestAdminController>(RequestAdminController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exeat Management System',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
