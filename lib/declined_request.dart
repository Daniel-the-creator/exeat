import 'package:flutter/material.dart';

class DeclinedRequests extends StatelessWidget {
  const DeclinedRequests({super.key});

  @override
  Widget build(BuildContext context) {
    final declinedData = [
      {"name": "John Ade", "matric": "DU0101", "reason": "Incomplete Form"},
      {"name": "Jane Bisi", "matric": "DU0102", "reason": "Exceeded Limit"},
      {"name": "Tolu Ayo", "matric": "DU0103", "reason": "Unauthorized Leave"},
      {"name": "Mary Oyin", "matric": "DU0104", "reason": "Invalid Reason"},
      {"name": "Chris Bello", "matric": "DU0105", "reason": "Late Submission"},
      {"name": "Sarah Nonso", "matric": "DU0106", "reason": "Invalid Document"},
      {"name": "James Cole", "matric": "DU0107", "reason": "False Details"},
      {"name": "Pelumi Ade", "matric": "DU0108", "reason": "Pending Review"},
      {"name": "Sayo King", "matric": "DU0109", "reason": "Incomplete Record"},
      {
        "name": "Dabiri Leke",
        "matric": "DU0110",
        "reason": "Violation of Rules"
      },
      {"name": "Tomi Ade", "matric": "DU0111", "reason": "Inconsistent Info"},
      {"name": "Samuel Tobi", "matric": "DU0112", "reason": "Not Approved"},
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Declined Requests",
          style: TextStyle(
            color: Color(0xff060121),
            fontWeight: FontWeight.bold,
          ),
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
          itemCount: declinedData.length,
          itemBuilder: (context, index) {
            final request = declinedData[index];
            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.white, Color(0xfffff0f0)],
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
                  backgroundColor: Colors.red.withOpacity(0.2),
                  child: const Icon(Icons.cancel, color: Colors.red),
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
