import 'package:exeat_system/new_exeat_form.dart';
import 'package:exeat_system/notificatons.dart';
import 'package:exeat_system/profile.dart';
import 'package:exeat_system/request_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 1000;

    double containerWidth = isSmallScreen
        ? screenWidth * 0.95
        : isMediumScreen
            ? screenWidth * 0.8
            : screenWidth * 0.6;

    double paddingValue = isSmallScreen
        ? 8
        : isMediumScreen
            ? 12
            : 16;

    double fontSizeTitle = isSmallScreen
        ? 18
        : isMediumScreen
            ? 20
            : 22;

    return Scaffold(
      backgroundColor: const Color(0xfff8f9ff),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color(0xff060121),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "WELCOME!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () => Get.to(() => const Profile()),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(paddingValue * 2),
        child: Center(
          child: Container(
            width: containerWidth,
            padding: EdgeInsets.all(paddingValue * 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ilesanmi Daniel",
                  style: TextStyle(
                    color: const Color(0xff060121),
                    fontSize: fontSizeTitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                _responsiveRow(
                  paddingValue,
                  [
                    _infoCard(
                      Icons.add_chart,
                      "APPLY FOR EXEAT",
                      "Submit a new request for leave from the campus.",
                      Colors.blueAccent,
                      () => Get.to(() => const NewExeatForm()),
                    ),
                    _infoCard(
                      Icons.list_alt_sharp,
                      "VIEW REQUESTS HISTORY",
                      "Check the status and details of your past exeat requests.",
                      Colors.orangeAccent,
                      () => Get.to(() => const RequestHistory()),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _responsiveRow(
                  paddingValue,
                  [
                    _infoCard(
                      Icons.notifications_active,
                      "NOTIFICATIONS",
                      "View important updates and alerts regarding your requests.",
                      Colors.purpleAccent,
                      () => Get.to(() => const Notifications()),
                    ),
                    _infoCard(
                      Icons.person_outline,
                      "PROFILE",
                      "Manage your personal info and account settings.",
                      Colors.teal,
                      () => Get.to(() => const Profile()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String description, Color color,
      VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.9), color.withOpacity(0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.white, size: 30),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _responsiveRow(double paddingValue, List<Widget> children) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: children
                .map((child) => Padding(
                      padding: EdgeInsets.only(bottom: paddingValue),
                      child: child,
                    ))
                .toList(),
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < children.length; i++) ...[
                Expanded(child: children[i]),
                if (i < children.length - 1) SizedBox(width: paddingValue * 2),
              ]
            ],
          );
        }
      },
    );
  }
}
