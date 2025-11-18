import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminNotifications extends StatefulWidget {
  const AdminNotifications({super.key});

  @override
  State<AdminNotifications> createState() => _AdminNotificationsState();
}

class _AdminNotificationsState extends State<AdminNotifications> {
  final List<Map<String, dynamic>> _notifications = [
    {
      "id": "1",
      "title": "New Exeat Request",
      "message":
          "John Doe has requested a weekend exeat to visit family in Lagos.",
      "time": "2 mins ago",
      "type": "request",
      "isRead": false,
      "action": "review_request",
      "studentName": "John Doe",
      "matricNumber": "MAT/2023/001"
    },
    {
      "id": "2",
      "title": "Request Approved",
      "message": "Jane Smith's medical exeat was successfully approved.",
      "time": "10 mins ago",
      "type": "approved",
      "isRead": true,
      "action": "view_approved",
    },
    {
      "id": "3",
      "title": "Request Declined",
      "message":
          "Chris Akin's travel exeat was declined due to incomplete documentation.",
      "time": "25 mins ago",
      "type": "declined",
      "isRead": true,
      "action": "view_declined",
    },
    {
      "id": "4",
      "title": "System Update Completed",
      "message":
          "Exeat analytics feature has been improved with new charts and reports.",
      "time": "1 hour ago",
      "type": "system",
      "isRead": false,
      "action": "view_analytics",
    },
    {
      "id": "5",
      "title": "New Student Registered",
      "message":
          "Pelumi Ade just registered as a new student in the Faculty of Engineering.",
      "time": "3 hours ago",
      "type": "user",
      "isRead": false,
      "action": "view_student",
    },
    {
      "id": "6",
      "title": "Pending Review Required",
      "message": "Tomi Ade's family visit exeat is pending your approval.",
      "time": "Yesterday",
      "type": "pending",
      "isRead": true,
      "action": "review_request",
      "studentName": "Tomi Ade",
      "matricNumber": "MAT/2023/015"
    },
    {
      "id": "7",
      "title": "Monthly Report Generated",
      "message":
          "October exeat summary report has been automatically generated.",
      "time": "Yesterday",
      "type": "system",
      "isRead": true,
      "action": "view_report",
    },
    {
      "id": "8",
      "title": "Late Return Alert",
      "message":
          "James Osy returned 3 hours late from exeat. Requires attention.",
      "time": "2 days ago",
      "type": "alert",
      "isRead": false,
      "action": "view_alert",
      "studentName": "James Osy",
      "matricNumber": "MAT/2023/008"
    },
  ];

  bool _showUnreadOnly = false;
  String _selectedFilter = "all";

  List<Map<String, dynamic>> get _filteredNotifications {
    List<Map<String, dynamic>> filtered = _notifications;

    if (_showUnreadOnly) {
      filtered = filtered.where((notif) => !notif["isRead"]).toList();
    }

    if (_selectedFilter != "all") {
      filtered =
          filtered.where((notif) => notif["type"] == _selectedFilter).toList();
    }

    return filtered;
  }

  int get _unreadCount {
    return _notifications.where((notif) => !notif["isRead"]).length;
  }

  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((notif) => notif["id"] == id);
      if (index != -1) {
        _notifications[index]["isRead"] = true;
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notif in _notifications) {
        notif["isRead"] = true;
      }
    });
    Get.snackbar(
      "All notifications marked as read",
      "",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    _markAsRead(notification["id"]);

    // Show notification details
    _showNotificationDetails(notification);
  }

  void _showNotificationDetails(Map<String, dynamic> notification) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildNotificationDetailSheet(notification),
    );
  }

  Widget _buildNotificationDetailSheet(Map<String, dynamic> notification) {
    final color = _getNotificationColor(notification["type"]!);
    final icon = _getNotificationIcon(notification["type"]!);

    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.2),
                  radius: 20,
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification["title"]!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff060121),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification["time"]!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification["message"]!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                if (notification["studentName"] != null) ...[
                  const SizedBox(height: 16),
                  _buildDetailItem("Student", notification["studentName"]!),
                  if (notification["matricNumber"] != null)
                    _buildDetailItem(
                        "Matric Number", notification["matricNumber"]!),
                ],
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _handleNotificationAction(notification);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      _getActionText(notification["action"]),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
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

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  String _getActionText(String action) {
    switch (action) {
      case "review_request":
        return "Review Request";
      case "view_approved":
        return "View Approved Requests";
      case "view_declined":
        return "View Declined Requests";
      case "view_analytics":
        return "View Analytics";
      case "view_student":
        return "View Student Profile";
      case "view_report":
        return "View Report";
      case "view_alert":
        return "View Alert Details";
      default:
        return "View Details";
    }
  }

  void _handleNotificationAction(Map<String, dynamic> notification) {
    final action = notification["action"];

    switch (action) {
      case "review_request":
        Get.toNamed('/pending-requests');
        break;
      case "view_approved":
        Get.toNamed('/approved-requests');
        break;
      case "view_declined":
        Get.toNamed('/declined-requests');
        break;
      case "view_analytics":
        Get.toNamed('/analytics');
        break;
      default:
        Get.snackbar(
          "Action triggered",
          "Handling: ${notification["title"]}",
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Color(0xff060121),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          if (_unreadCount > 0)
            Badge(
              label: Text(_unreadCount.toString()),
              backgroundColor: Colors.red,
              textColor: Colors.white,
              child: IconButton(
                icon:
                    const Icon(Icons.mark_email_read, color: Color(0xff060121)),
                onPressed: _markAllAsRead,
                tooltip: "Mark all as read",
              ),
            ),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                if (value == "mark_all_read") {
                  _markAllAsRead();
                } else if (value == "toggle_unread") {
                  _showUnreadOnly = !_showUnreadOnly;
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "mark_all_read",
                child: Row(
                  children: const [
                    Icon(Icons.mark_email_read, size: 20),
                    SizedBox(width: 8),
                    Text("Mark all as read"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "toggle_unread",
                child: Row(
                  children: [
                    Icon(
                        _showUnreadOnly
                            ? Icons.filter_alt_off
                            : Icons.filter_alt,
                        size: 20),
                    const SizedBox(width: 8),
                    Text(_showUnreadOnly ? "Show all" : "Show unread only"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip("All", "all"),
                  const SizedBox(width: 8),
                  _buildFilterChip("Requests", "request"),
                  const SizedBox(width: 8),
                  _buildFilterChip("Alerts", "alert"),
                  const SizedBox(width: 8),
                  _buildFilterChip("System", "system"),
                  const SizedBox(width: 8),
                  _buildFilterChip("Users", "user"),
                ],
              ),
            ),
          ),

          // Notifications List
          Expanded(
            child: _filteredNotifications.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 12 : 24,
                      vertical: 16,
                    ),
                    itemCount: _filteredNotifications.length,
                    itemBuilder: (context, index) {
                      final notif = _filteredNotifications[index];
                      return _buildNotificationCard(notif);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? value : "all";
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: const Color(0xff060121).withOpacity(0.1),
      checkmarkColor: const Color(0xff060121),
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xff060121) : Colors.grey[700],
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notif) {
    final color = _getNotificationColor(notif["type"]!);
    final icon = _getNotificationIcon(notif["type"]!);
    final isUnread = !notif["isRead"];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleNotificationTap(notif),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  color.withOpacity(isUnread ? 0.12 : 0.06),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isUnread ? color.withOpacity(0.3) : Colors.transparent,
                width: isUnread ? 2 : 0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Indicator
                if (isUnread)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 8, right: 12),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  )
                else
                  const SizedBox(width: 20),

                // Icon
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.15),
                  radius: 20,
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notif["title"]!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff060121),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            notif["time"]!,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notif["message"]!,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            _showUnreadOnly ? "No unread notifications" : "No notifications",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff060121),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _showUnreadOnly
                ? "You're all caught up!"
                : "Notifications will appear here",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
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
