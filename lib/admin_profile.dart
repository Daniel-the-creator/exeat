import 'package:exeat_system/home_page.dart';
import 'package:exeat_system/login_screen__student.dart';
import 'package:exeat_system/profile_controller.dart';
import 'package:exeat_system/set_new_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAdmin extends StatelessWidget {
  const ProfileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: const Color(0xff060121),
            elevation: 0,
            pinned: true,
            expandedHeight: isSmallScreen ? 120 : 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Profile Settings",
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xff060121),
                      const Color(0xff1a0f3e),
                      const Color(0xff2d1b5e),
                    ],
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 20),
              ),
              onPressed: () => Get.to(() => const HomePage()),
            ),
          ),

          // Profile Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
              child: Column(
                children: [
                  // Profile Header Card
                  _buildProfileHeader(context, isSmallScreen),

                  const SizedBox(height: 24),

                  // Account Settings Section
                  _buildAccountSettingsSection(context, isSmallScreen),

                  const SizedBox(height: 20),

                  // Additional Options
                  _buildAdditionalOptions(context, isSmallScreen),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, bool isSmallScreen) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xff060121),
            const Color(0xff1a0f3e),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Avatar
          Container(
            width: isSmallScreen ? 70 : 90,
            height: isSmallScreen ? 70 : 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade300,
                  Colors.purple.shade300,
                ],
              ),
            ),
            child: Stack(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.admin_panel_settings_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.verified,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Profile Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Administrator",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 18 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "System Administrator",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: isSmallScreen ? 12 : 14,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Admin Access",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 10 : 12,
                      fontWeight: FontWeight.w600,
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

  Widget _buildAccountSettingsSection(
      BuildContext context, bool isSmallScreen) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xff060121).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.settings_rounded,
                    color: Color(0xff060121), size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                "Account Settings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 18 : 20,
                  color: const Color(0xff060121),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Change Password Card
          _buildSettingCard(
            icon: Icons.lock_reset_rounded,
            title: "Change Password",
            subtitle: "Update your account password",
            color: Colors.blue,
            onTap: () => Get.to(() => const SetNewPassword()),
            isSmallScreen: isSmallScreen,
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildAdditionalOptions(BuildContext context, bool isSmallScreen) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.logout_rounded,
                    color: Colors.red, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                "Session",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 18 : 20,
                  color: const Color(0xff060121),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Logout Button
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.shade600,
                  Colors.red.shade800,
                ],
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _showLogoutConfirmation(context);
                },
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout_rounded,
                          color: Colors.white, size: 22),
                      const SizedBox(width: 12),
                      Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 16 : 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Clear Cache Button
          _buildSettingCard(
            icon: Icons.cleaning_services_rounded,
            title: "Clear Cache",
            subtitle: "Clear temporary data and cache",
            color: Colors.purple,
            onTap: () {
              Get.snackbar(
                "Cache Cleared",
                "Temporary data has been cleared successfully",
                backgroundColor: Colors.purple,
                colorText: Colors.white,
              );
            },
            isSmallScreen: isSmallScreen,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    required bool isSmallScreen,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: isSmallScreen ? 14 : 16,
                          color: const Color(0xff060121),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 11 : 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    color: Colors.grey[400], size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  const Icon(Icons.logout_rounded, color: Colors.red, size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              "Confirm Logout",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff060121),
              ),
            ),
          ],
        ),
        content: const Text(
          "Are you sure you want to logout from your account?",
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Get.offAll(() => const LoginScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
