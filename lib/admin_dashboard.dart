import 'package:exeat_system/pending_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int pendingRequests = 5;
  int approvedRequests = 12;
  int declinedRequests = 2;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 1000;

    double containerWidth = isSmallScreen
        ? screenWidth * 0.95
        : isMediumScreen
            ? screenWidth * 0.85
            : screenWidth * 0.7;

    double paddingValue = isSmallScreen ? 10 : 16;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xff060121),
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(paddingValue),
        child: Center(
          child: Container(
            width: containerWidth,
            padding: EdgeInsets.all(paddingValue),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome, Admin 👋",
                  style: TextStyle(
                    color: Color(0xff060121),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 10),

                // 📊 Stats Cards Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _statCard("Pending", pendingRequests, Colors.orange),
                    _statCard("Approved", approvedRequests, Colors.green),
                    _statCard("Declined", declinedRequests, Colors.red),
                  ],
                ),

                const SizedBox(height: 30),
                const Text(
                  "Quick Actions",
                  style: TextStyle(
                    color: Color(0xff060121),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                // 🧭 Action cards
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    _actionCard(
                      icon: Icons.pending_actions,
                      title: "Pending Requests",
                      description:
                          "View and approve pending exeat requests from students.",
                      color: Colors.orange[100]!,
                      onTap: () {
                        Get.to(() => const PendingRequests());
                      },
                    ),
                    _actionCard(
                      icon: Icons.check_circle,
                      title: "Approved Requests",
                      description: "See all approved exeat requests.",
                      color: Colors.green[100]!,
                      onTap: () {
                        // Get.to(() => const ApprovedRequestsPage());
                      },
                    ),
                    _actionCard(
                      icon: Icons.cancel_outlined,
                      title: "Declined Requests",
                      description: "Review all declined exeat requests.",
                      color: Colors.red[100]!,
                      onTap: () {
                        // Get.to(() => const DeclinedRequestsPage());
                      },
                    ),
                    _actionCard(
                      icon: Icons.notifications,
                      title: "Notifications",
                      description: "Check important updates or system alerts.",
                      color: Colors.blue[100]!,
                      onTap: () {
                        // Get.to(() => const NotificationsPage());
                      },
                    ),
                    _actionCard(
                      icon: Icons.people,
                      title: "Students",
                      description:
                          "View student list and monitor exeat activity.",
                      color: Colors.purple[100]!,
                      onTap: () {
                        // Get.to(() => const StudentListPage());
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

  Widget _statCard(String title, int count, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Text(
              "$count",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: const Color(0xff060121)),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xff060121),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black87, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
