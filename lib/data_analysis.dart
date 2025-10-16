import 'package:flutter/material.dart';

class ViewExeatActivity extends StatelessWidget {
  const ViewExeatActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final exeatData = [
      {
        "name": "John Doe",
        "matric": "DU001",
        "reason": "Family Visit",
        "status": "Approved",
        "duration": "3 Days"
      },
      {
        "name": "Jane Smith",
        "matric": "DU002",
        "reason": "Medical Leave",
        "status": "Pending",
        "duration": "-"
      },
      {
        "name": "Samuel Bright",
        "matric": "DU003",
        "reason": "Personal Errand",
        "status": "Declined",
        "duration": "-"
      },
      {
        "name": "Gloria Daniels",
        "matric": "DU004",
        "reason": "Competition",
        "status": "Approved",
        "duration": "5 Days"
      },
      {
        "name": "Michael James",
        "matric": "DU005",
        "reason": "Emergency",
        "status": "Pending",
        "duration": "-"
      },
      {
        "name": "Sophia George",
        "matric": "DU006",
        "reason": "Church Event",
        "status": "Approved",
        "duration": "2 Days"
      },
      {
        "name": "Daniel Adams",
        "matric": "DU007",
        "reason": "Sick Leave",
        "status": "Declined",
        "duration": "-"
      },
      {
        "name": "Esther Brown",
        "matric": "DU008",
        "reason": "Family Function",
        "status": "Pending",
        "duration": "-"
      },
      {
        "name": "David Clark",
        "matric": "DU009",
        "reason": "Sports Trip",
        "status": "Approved",
        "duration": "4 Days"
      },
      {
        "name": "Faith Johnson",
        "matric": "DU010",
        "reason": "Medical Review",
        "status": "Approved",
        "duration": "1 Day"
      },
      {
        "name": "Peter Nelson",
        "matric": "DU011",
        "reason": "Home Visit",
        "status": "Pending",
        "duration": "-"
      },
      {
        "name": "Lucy Williams",
        "matric": "DU012",
        "reason": "Workshop",
        "status": "Approved",
        "duration": "2 Days"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exeat Activity Monitor"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 600;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: isWide
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: exeatData.length,
                    itemBuilder: (context, index) {
                      return _buildExeatCard(exeatData[index]);
                    },
                  )
                : ListView.builder(
                    itemCount: exeatData.length,
                    itemBuilder: (context, index) {
                      return _buildExeatCard(exeatData[index]);
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget _buildExeatCard(Map<String, String> data) {
    Color statusColor;
    IconData icon;

    switch (data["status"]) {
      case "Approved":
        statusColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case "Pending":
        statusColor = Colors.orange;
        icon = Icons.hourglass_empty;
        break;
      case "Declined":
        statusColor = Colors.red;
        icon = Icons.cancel;
        break;
      default:
        statusColor = Colors.grey;
        icon = Icons.info;
    }

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data["name"]!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(icon, color: statusColor, size: 28),
              ],
            ),
            const SizedBox(height: 8),

            // Details
            Text(
              "Matric No: ${data["matric"]}",
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              "Reason: ${data["reason"]}",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),

            // Status + Duration
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    data["status"]!,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  "Duration: ${data["duration"]}",
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
