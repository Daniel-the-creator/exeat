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
        ? 14
        : isMediumScreen
            ? 16
            : 18;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color(0xff060121),
          leading: const Icon(Icons.settings, color: Colors.white),
          titleSpacing: 5,
          title: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: paddingValue, vertical: 5),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "WELCOME!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(paddingValue),
        child: Center(
          child: Container(
            width: containerWidth * 4,
            padding: EdgeInsets.all(paddingValue * 2),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff060121)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ILESANMI DANIEL",
                  style: TextStyle(
                    color: const Color(0xff060121),
                    fontSize: fontSizeTitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _responsiveRow(
                  paddingValue,
                  [
                    GestureDetector(
                      child: _infoCard(
                        Icons.add_chart,
                        "APPLY FOR EXEAT",
                        "Submit a new request for leave from the campus.",
                        paddingValue,
                      ),
                      onTap: () {
                        Get.to(() => const NewExeatForm());
                      },
                    ),
                    GestureDetector(
                      child: _infoCard(
                        Icons.list_alt_sharp,
                        "VIEW REQUEST",
                        "Check the status and details of your past exeat requests.",
                        paddingValue,
                      ),
                      onTap: () {
                        Get.to(() => const RequestHistory());
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _responsiveRow(
                  paddingValue,
                  [
                    GestureDetector(
                      child: _infoCard(
                        Icons.notifications,
                        "NOTIFICATIONS",
                        "View important updates and alerts regarding your requests",
                        paddingValue,
                      ),
                      onTap: () {
                        Get.to(() => const Notifications());
                      },
                    ),
                    GestureDetector(
                      child: _infoCard(
                        Icons.person,
                        "PROFILE",
                        "Manage your personal information and account settings.",
                        paddingValue,
                      ),
                      onTap: () {
                        Get.to(() => const Profile());
                      },
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

  // -------------------- Helper Widgets --------------------

  Widget _menuItem(String title, double fontSize, double paddingValue) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: paddingValue * 1.2,
        vertical: paddingValue * 0.5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
    );
  }

  Widget _infoCard(
      IconData icon, String title, String description, double paddingValue) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: paddingValue),
        padding: EdgeInsets.all(paddingValue),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff060121), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xff060121)),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xff060121),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(color: Color(0xff060121)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _responsiveRow(double paddingValue, List<Widget> children) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Stack vertically on small screens
          return Column(
            children: children
                .map((child) => Padding(
                      padding: EdgeInsets.only(bottom: paddingValue),
                      child: child,
                    ))
                .toList(),
          );
        } else {
          // Place side-by-side on large screens
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < children.length; i++) ...[
                Expanded(child: children[i]),
                if (i < children.length - 1)
                  SizedBox(width: paddingValue * 2), // space between
              ]
            ],
          );
        }
      },
    );
  }
}
