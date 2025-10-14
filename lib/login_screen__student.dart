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

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    
    double containerWidth = screenWidth < 600 ? screenWidth * 0.9 : screenWidth * 0.4;
    double fontSizeTitle = screenWidth < 600 ? 24 : 32;
    double fontSizeButton = screenWidth < 600 ? 14 : 18;
    double paddingValue = screenWidth < 600 ? 12 : 20;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: containerWidth,
            padding: EdgeInsets.all(paddingValue),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "WELCOME!!",
                  style: TextStyle(
                    color: const Color(0xff060121),
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeTitle,
                  ),
                ),
                const SizedBox(height: 20),

                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingValue * 1.2,
                        vertical: paddingValue * 0.6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xff060121),
                      ),
                      child: Text(
                        "Student",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeButton,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: paddingValue * 1.5,
                          vertical: paddingValue * 0.6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey,
                        ),
                        child: Text(
                          "Admin",
                          style: TextStyle(
                            color: const Color(0xff060121),
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeButton,
                          ),
                        ),
                      ),
                       onTap: () {
                            Get.to(() => const LoginscreenStaff());
                          },
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Matric number',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey[700],
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: const Color(0xff060121)),
                    padding: EdgeInsets.symmetric(horizontal: paddingValue * 1.2, vertical: paddingValue * 0.8),
                    child:  Center(child: Text("LOG IN",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: fontSizeButton ),),),),
                onTap: () {
                            Get.to(() => const HomePage());
                          },
                ),
                  const SizedBox(height: 20,),
                 Center(child: GestureDetector(child: Text("Forgot password?",style: TextStyle( fontSize: fontSizeButton),),
                 onTap: () {
                            Get.to(() => const ForgotPassword());
                          },
                 ),), 
             const SizedBox(height: 20,),
                 Center(child: GestureDetector(
                   child: Text("don't have an account? Sign Up",
                   style: TextStyle(decoration: TextDecoration.underline, fontSize: fontSizeButton),),
                 onTap: () {
                            Get.to(() => const Signup());
                          },
                 ),
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}