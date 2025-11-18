import 'package:exeat_system/new_exeat_form.dart';
import 'package:exeat_system/notificatons.dart';
import 'package:exeat_system/profile.dart';
import 'package:exeat_system/profile_controller.dart';
import 'package:exeat_system/request_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final profileController = Get.put(ProfileController());

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
      backgroundColor: const Color(0xff060121),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff060121),
                  Color(0xff1a0f3e),
                  Color(0xff2d1b5e),
                ],
              ),
            ),
          ),
          title: FadeTransition(
            opacity: _fadeAnimation,
            child: const Text(
              "WELCOME!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          actions: [
            ScaleTransition(
              scale: _fadeAnimation,
              child: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.settings, color: Colors.white, size: 24),
                ),
                onPressed: () => Get.to(() => const Profile()),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff060121),
              Color(0xff1a0f3e),
              Color(0xff2d1b5e),
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(paddingValue * 2),
              child: Center(
                child: Container(
                  width: containerWidth,
                  padding: EdgeInsets.all(paddingValue * 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 40,
                        spreadRadius: 5,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome message with animation
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello,",
                              style: TextStyle(
                                color: const Color(0xff060121),
                                fontSize: fontSizeTitle - 2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Obx(() => Text(
                                  profileController.fullName.value
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: const Color(0xff060121),
                                    fontSize: fontSizeTitle + 4,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "What would you like to do today?",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // First row of cards
                      _responsiveRow(
                        paddingValue,
                        [
                          _animatedInfoCard(
                            Icons.add_chart_rounded,
                            "APPLY FOR EXEAT",
                            "Submit a new request for leave from the campus.",
                            const [Color(0xff667eea), Color(0xff764ba2)],
                            0,
                            () => Get.to(() => const NewExeatForm()),
                          ),
                          _animatedInfoCard(
                            Icons.history_rounded,
                            "REQUEST HISTORY",
                            "Check the status and details of your past exeat requests.",
                            const [Color(0xfff093fb), Color(0xfff5576c)],
                            100,
                            () => Get.to(() => const RequestHistory()),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Second row of cards
                      _responsiveRow(
                        paddingValue,
                        [
                          _animatedInfoCard(
                            Icons.notifications_active_rounded,
                            "NOTIFICATIONS",
                            "View important updates and alerts regarding your requests.",
                            const [Color(0xff4facfe), Color(0xff00f2fe)],
                            200,
                            () => Get.to(() => const Notifications()),
                          ),
                          _animatedInfoCard(
                            Icons.person_rounded,
                            "PROFILE",
                            "Manage your personal info and account settings.",
                            const [Color(0xff43e97b), Color(0xff38f9d7)],
                            300,
                            () => Get.to(() => const Profile()),
                          ),
                        ],
                      ),

                      // Quick Stats Section
                      const SizedBox(height: 40),
                      _buildQuickStats(paddingValue),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _animatedInfoCard(
    IconData icon,
    String title,
    String description,
    List<Color> gradientColors,
    int delay,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: MouseRegion(
          onEnter: (_) => _scaleController.forward(),
          onExit: (_) => _scaleController.reverse(),
          child: ScaleTransition(
            scale: Tween<double>(begin: 1.0, end: 1.05).animate(
              CurvedAnimation(
                  parent: _scaleController, curve: Curves.easeInOut),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: gradientColors[0].withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 20,
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

  Widget _buildQuickStats(double paddingValue) {
    return Container(
      padding: EdgeInsets.all(paddingValue * 1.5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff060121),
            Color(0xff2d1b5e),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff060121).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "QUICK STATS",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          _responsiveRow(
            paddingValue,
            [
              _statItem("Pending Requests", "2", Icons.pending_actions_rounded),
              _statItem("Approved", "5", Icons.verified_rounded),
              _statItem("Rejected", "1", Icons.cancel_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(String title, String count, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 8),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
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
