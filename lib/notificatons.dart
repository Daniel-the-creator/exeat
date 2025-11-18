import 'package:exeat_system/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<GlobalKey> _itemKeys = List.generate(6, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double containerWidth =
        screenWidth < 600 ? screenWidth * 0.95 : screenWidth * 0.6;
    double fontSizeTitle = screenWidth < 600 ? 24 : 30;
    double fontSizeBody = screenWidth < 600 ? 14 : 16;
    double paddingValue = screenWidth < 600 ? 16 : 24;
    double spacingValue = screenWidth < 600 ? 12 : 16;

    final notifications = [
      {
        'title': 'Exeat Approved!',
        'message': 'Your exeat to Lagos has been approved.',
        'time': '10 minutes ago',
        'icon': Icons.check_circle_rounded,
        'color': Colors.green.shade50,
        'iconColor': Colors.green,
        'isNew': true,
      },
      {
        'title': 'Request Rejected',
        'message': 'Your exeat for the upcoming weekend was rejected.',
        'time': '35 minutes ago',
        'icon': Icons.cancel_rounded,
        'color': Colors.red.shade50,
        'iconColor': Colors.red,
        'isNew': true,
      },
      {
        'title': 'Pending Approval',
        'message':
            'Your request for vacation is still awaiting approval from the HOD.',
        'time': '1 hour ago',
        'icon': Icons.hourglass_empty_rounded,
        'color': Colors.orange.shade50,
        'iconColor': Colors.orange,
        'isNew': false,
      },
      {
        'title': 'Exeat Approved!',
        'message': 'Your exeat to Lagos has been approved.',
        'time': '2 hours ago',
        'icon': Icons.check_circle_rounded,
        'color': Colors.green.shade50,
        'iconColor': Colors.green,
        'isNew': false,
      },
      {
        'title': 'Request Rejected',
        'message': 'Your exeat for the upcoming weekend was rejected.',
        'time': '5 hours ago',
        'icon': Icons.cancel_rounded,
        'color': Colors.red.shade50,
        'iconColor': Colors.red,
        'isNew': false,
      },
      {
        'title': 'Pending Approval',
        'message':
            'Your request for vacation is still awaiting approval from the HOD.',
        'time': '8 hours ago',
        'icon': Icons.hourglass_empty_rounded,
        'color': Colors.orange.shade50,
        'iconColor': Colors.orange,
        'isNew': false,
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff060121),
              Color(0xff1a0f3e),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: paddingValue,
                  vertical: paddingValue * 0.8,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => Get.to(() => const HomePage()),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "Notifications",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: fontSizeTitle,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${notifications.where((n) => n['isNew'] == true).length} New',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Notifications List
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: paddingValue * 0.5),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.all(paddingValue),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return _buildAnimatedNotificationCard(
                        index: index,
                        title: notification['title'] as String,
                        message: notification['message'] as String,
                        time: notification['time'] as String,
                        icon: notification['icon'] as IconData,
                        color: notification['color'] as Color,
                        iconColor: notification['iconColor'] as Color,
                        isNew: notification['isNew'] as bool,
                        fontSize: fontSizeBody,
                        spacing: spacingValue,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedNotificationCard({
    required int index,
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required bool isNew,
    required double fontSize,
    required double spacing,
  }) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final delay = index * 0.1;
        final animationValue = Curves.easeOutCubic.transform(
          (_animationController.value - delay).clamp(0.0, 1.0) / (1.0 - delay),
        );

        return Transform.translate(
          offset: Offset(0, 50 * (1 - animationValue)),
          child: Opacity(
            opacity: animationValue,
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spacing),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isNew
              ? Border.all(color: iconColor.withOpacity(0.3), width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: iconColor.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Handle notification tap
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon Container
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          iconColor.withOpacity(0.8),
                          iconColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: iconColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 24,
                    ),
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
                                title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize + 2,
                                  color: const Color(0xff060121),
                                ),
                              ),
                            ),
                            if (isNew)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: iconColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 14,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              time,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: fontSize - 2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
