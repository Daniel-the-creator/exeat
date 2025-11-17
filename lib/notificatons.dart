import 'package:exeat_system/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double containerWidth =
        screenWidth < 600 ? screenWidth * 0.95 : screenWidth * 0.6;
    double fontSizeTitle = screenWidth < 600 ? 22 : 28;
    double fontSizeBody = screenWidth < 600 ? 14 : 16;
    double paddingValue = screenWidth < 600 ? 12 : 20;
    double spacingValue = screenWidth < 600 ? 15 : 20;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(paddingValue),
            child: Container(
              width: containerWidth,
              padding: EdgeInsets.all(paddingValue),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back and title row
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(() => const HomePage()),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.black87, size: 22),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Notifications",
                        style: TextStyle(
                          color: const Color(0xff060121),
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeTitle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacingValue + 5),

                  _buildNotificationCard(
                    title: "Exeat Approved!",
                    message: "Your exeat to Lagos has been approved.",
                    time: "10 minutes ago",
                    icon: Icons.check_circle,
                    color: Colors.green.shade100,
                    iconColor: Colors.green,
                    fontSize: fontSizeBody,
                  ),
                  SizedBox(height: spacingValue),

                  _buildNotificationCard(
                    title: "Request Rejected",
                    message:
                        "Your exeat for the upcoming weekend was rejected.",
                    time: "35 minutes ago",
                    icon: Icons.cancel,
                    color: Colors.red.shade100,
                    iconColor: Colors.red,
                    fontSize: fontSizeBody,
                  ),
                  SizedBox(height: spacingValue),

                  _buildNotificationCard(
                    title: "Pending Approval",
                    message:
                        "Your request for vacation is still awaiting approval from the HOD.",
                    time: "1 hour ago",
                    icon: Icons.hourglass_empty,
                    color: Colors.orange.shade100,
                    iconColor: Colors.orange,
                    fontSize: fontSizeBody,
                  ),
                  SizedBox(height: spacingValue),

                  _buildNotificationCard(
                    title: "Exeat Approved!",
                    message: "Your exeat to Lagos has been approved.",
                    time: "2 hours ago",
                    icon: Icons.check_circle,
                    color: Colors.green.shade100,
                    iconColor: Colors.green,
                    fontSize: fontSizeBody,
                  ),
                  SizedBox(height: spacingValue),

                  _buildNotificationCard(
                    title: "Request Rejected",
                    message:
                        "Your exeat for the upcoming weekend was rejected.",
                    time: "5 hours ago",
                    icon: Icons.cancel,
                    color: Colors.red.shade100,
                    iconColor: Colors.red,
                    fontSize: fontSizeBody,
                  ),
                  SizedBox(height: spacingValue),

                  _buildNotificationCard(
                    title: "Pending Approval",
                    message:
                        "Your request for vacation is still awaiting approval from the HOD.",
                    time: "8 hours ago",
                    icon: Icons.hourglass_empty,
                    color: Colors.orange.shade100,
                    iconColor: Colors.orange,
                    fontSize: fontSizeBody,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required double fontSize,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize + 1,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    time,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: fontSize - 2,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
