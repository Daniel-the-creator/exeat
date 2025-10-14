import 'package:exeat_system/login_screen__student.dart';
import 'package:exeat_system/signup_staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscurePassword = true;
  String? selectedHostel;

  final List<String> hostels = [
    'Rehoboth hall',
    'New hall',
    'Victory hall',
    'Faith hall',
    'Newest hall',
    'Bishop hall',
  ];

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
                  "REGISTER!!",
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
                            Get.to(() => const SignupStaff());
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
                      hintText: 'Full Name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  TextField(
                    decoration: const InputDecoration(
                      hintText: 'phone number',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                  ),
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
                const SizedBox(height: 25),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'email',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedHostel,
          isExpanded: true, 
          hint: const Text("Select Your Hostel"),
          icon: const Icon(Icons.arrow_drop_down),
          items: hostels.map((String hostel) {
            return DropdownMenuItem<String>(
              value: hostel,
              child: Text(hostel),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedHostel = newValue!;
            });
          },
        ),
      ),
    ),
                const SizedBox(height: 25),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'create Password',
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
                const SizedBox(height: 25,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'confirm Password',
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
                const SizedBox(height: 25,),
               const SizedBox(height: 20),
                 GestureDetector(
                   child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: const Color(0xff060121)),
                    padding: EdgeInsets.symmetric(horizontal: paddingValue * 1.2, vertical: paddingValue * 0.8),
                    child:  Center(child: Text("SIGN UP",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: fontSizeButton ),),),),
                  onTap: () {
                            Get.to(() => const LoginScreen());
                          },
                 ),
             const SizedBox(height: 20,),
                 Center(child: GestureDetector(
                   child: Text("already have an account? Log In",
                   style: TextStyle(decoration: TextDecoration.underline, fontSize: fontSizeButton),),
                 onTap: () {
                            Get.to(() => const LoginScreen());
                          },
                 ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}