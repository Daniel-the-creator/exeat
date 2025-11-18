import 'package:exeat_system/forgot_password.dart';
import 'package:exeat_system/home_page.dart';
import 'package:exeat_system/loginscreen_staff.dart';
import 'package:exeat_system/signup_student.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool _obscurePassword = true;
  bool _isStudent = true;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _formKey = GlobalKey<FormState>();
  final _matricController = TextEditingController();
  final _passwordController = TextEditingController();

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

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _matricController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      Get.to(() => const HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double containerWidth =
        screenWidth < 600 ? screenWidth * 0.9 : screenWidth * 0.4;
    double fontSizeTitle = screenWidth < 600 ? 28 : 36;
    double fontSizeButton = screenWidth < 600 ? 14 : 16;
    double paddingValue = screenWidth < 600 ? 16 : 24;

    return Scaffold(
      body: Container(
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
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                child: Container(
                  width: containerWidth,
                  margin: EdgeInsets.symmetric(vertical: paddingValue),
                  padding: EdgeInsets.all(paddingValue * 1.5),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo or Icon
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff060121),
                                const Color(0xff2d1b5e),
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff060121).withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.school_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Welcome Text
                        Text(
                          "WELCOME!",
                          style: TextStyle(
                            color: const Color(0xff060121),
                            fontWeight: FontWeight.w900,
                            fontSize: fontSizeTitle,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Sign in to continue",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: fontSizeButton,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Tab Selector
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildTabButton(
                                  "Student",
                                  _isStudent,
                                  () {
                                    setState(() {
                                      _isStudent = true;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: _buildTabButton(
                                  "Admin",
                                  !_isStudent,
                                  () {
                                    setState(() {
                                      _isStudent = false;
                                    });
                                    Get.to(() => const LoginscreenStaff());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Input Fields
                        _buildInputField(
                          hintText: _isStudent ? 'Matric number' : 'Staff ID',
                          icon: Icons.person_outline_rounded,
                          controller: _matricController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your ${_isStudent ? 'matric number' : 'staff ID'}';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        _buildPasswordField(),
                        const SizedBox(height: 28),

                        // Login Button
                        _buildLoginButton(paddingValue, fontSizeButton),
                        const SizedBox(height: 20),

                        // Forgot Password
                        TextButton(
                          onPressed: () {
                            Get.to(() => const ForgotPassword());
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                          ),
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontSize: fontSizeButton,
                              color: const Color(0xff060121),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Sign Up Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: fontSizeButton,
                                color: Colors.grey[700],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const Signup());
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: fontSizeButton,
                                  color: const Color(0xff060121),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: [
                    const Color(0xff060121),
                    const Color(0xff2d1b5e),
                  ],
                )
              : null,
          color: isActive ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xff060121).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1.5),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(icon, color: const Color(0xff060121)),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          errorStyle: const TextStyle(height: 0.8, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1.5),
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon:
              const Icon(Icons.lock_outline_rounded, color: Color(0xff060121)),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          errorStyle: const TextStyle(height: 0.8, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildLoginButton(double paddingValue, double fontSizeButton) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff060121),
            const Color(0xff2d1b5e),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff060121).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleLogin,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: paddingValue * 0.9),
            child: Center(
              child: Text(
                "LOG IN",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeButton + 2,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
