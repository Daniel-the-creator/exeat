import 'package:flutter/material.dart';

class AdminNotifications extends StatelessWidget {
  const AdminNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "New Exeat Request",
        "message": "John Doe has requested a weekend exeat.",
        "time": "2 mins ago",
        "type": "request",
      },
      {
        "title": "Request Approved",
        "message": "Jane Smith’s medical exeat was approved.",
        "time": "10 mins ago",
        "type": "approved",
      },
      {
        "title": "Request Declined",
        "message": "Chris Akin’s travel exeat was declined.",
        "time": "25 mins ago",
        "type": "declined",
      },
      {
        "title": "System Update",
        "message": "Exeat analytics feature has been improved.",
        "time": "1 hour ago",
        "type": "system",
      },
      {
        "title": "New User Registered",
        "message": "Pelumi Ade just registered as a new student.",
        "time": "3 hours ago",
        "type": "user",
      },
      {
        "title": "Pending Review",
        "message": "Tomi Ade’s family visit exeat is pending approval.",
        "time": "Yesterday",
        "type": "pending",
      },
      {
        "title": "Report Generated",
        "message": "Daily exeat summary report has been generated.",
        "time": "Yesterday",
        "type": "system",
      },
      {
        "title": "Late Return Notice",
        "message": "James Osy returned 3 hours late from exeat.",
        "time": "2 days ago",
        "type": "alert",
      },
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Admin Notifications",
          style: TextStyle(
            color: Color(0xff060121),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 40,
          vertical: 20,
        ),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notif = notifications[index];
            final color = _getNotificationColor(notif["type"]!);
            final icon = _getNotificationIcon(notif["type"]!);

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, color.withOpacity(0.08)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: color.withOpacity(0.15),
                    radius: 25,
                    child: Icon(icon, color: color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notif["title"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff060121),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          notif["message"]!,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          notif["time"]!,
                          style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.black45),
                    onPressed: () {},
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case "request":
        return Colors.blueAccent;
      case "approved":
        return Colors.green;
      case "declined":
        return Colors.redAccent;
      case "pending":
        return Colors.orangeAccent;
      case "system":
        return Colors.purpleAccent;
      case "alert":
        return Colors.deepOrange;
      case "user":
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case "request":
        return Icons.email_outlined;
      case "approved":
        return Icons.check_circle_outline;
      case "declined":
        return Icons.cancel_outlined;
      case "pending":
        return Icons.hourglass_bottom;
      case "system":
        return Icons.system_update_alt;
      case "alert":
        return Icons.warning_amber_outlined;
      case "user":
        return Icons.person_add_alt_1;
      default:
        return Icons.notifications_none;
    }
  }
}
