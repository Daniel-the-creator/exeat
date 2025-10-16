import 'package:flutter/material.dart';

class ApprovedRequests extends StatelessWidget {
  const ApprovedRequests({super.key});

  @override
  Widget build(BuildContext context) {
    final approvedData = [
      {"name": "John ayemanika", "matric": "DU0001", "reason": "Family Visit"},
      {
        "name": "Jane adebayo",
        "matric": "DU0002",
        "reason": "Medical Appointment"
      },
      {"name": "tolu Johnson", "matric": "DU0003", "reason": "Official Leave"},
      {"name": "Mary oyin", "matric": "DU0004", "reason": "Personal Errand"},
      {"name": "Chris akin", "matric": "DU0005", "reason": "Health Check"},
      {"name": "Sarah nonso", "matric": "DU0006", "reason": "Seminar"},
      {"name": "James osy", "matric": "DU0007", "reason": "Home Emergency"},
      {"name": "pelumi ade", "matric": "DU0008", "reason": "Travel"},
      {"name": "sayo King", "matric": "DU0009", "reason": "Wedding"},
      {"name": "dabiri leke", "matric": "DU0010", "reason": "Medical"},
      {"name": "Tomi Ade", "matric": "DU0011", "reason": "Project Research"},
      {"name": "Samuel tobi", "matric": "DU0012", "reason": "Conference"},
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Approved Request",
          style:
              TextStyle(color: Color(0xff060121), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 40,
          vertical: 20,
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isSmallScreen ? 1 : 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: isSmallScreen ? 3.5 : 3.8,
          ),
          itemCount: approvedData.length,
          itemBuilder: (context, index) {
            final request = approvedData[index];
            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.white, Color(0xfff0f1ff)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                leading: CircleAvatar(
                  backgroundColor: Colors.green.withOpacity(0.2),
                  child: const Icon(Icons.check_circle, color: Colors.green),
                ),
                title: Text(
                  request["name"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xff060121),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    "Matric No: ${request["matric"]}\nReason: ${request["reason"]}",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
