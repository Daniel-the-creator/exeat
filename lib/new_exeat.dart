import 'package:exeat_system/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NewExeat extends StatefulWidget {
  const NewExeat({super.key});

  @override
  State<NewExeat> createState() => _NewExeatState();
}

class _NewExeatState extends State<NewExeat> {
  String? selectedHostel;

  final List<String> hostels = [
    'APPROVED',
    'PENDING',
    'REJECTED',
  ];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double containerWidth =
        screenWidth < 600 ? screenWidth * 0.9 : screenWidth * 0.4;
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
                  "NEW EXEAT REQUEST",
                  style: TextStyle(
                    color: const Color(0xff060121),
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeTitle,
                  ),
                ),
                Text(
                  "fill in the details below to submit your exeat application",
                  style: TextStyle(
                    color: const Color(0xff060121),
                    fontSize: fontSizeTitle,
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Contact information',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'LEAVE DATE',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'LEAVE TIME',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'RETURN DATE',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'RETURN TIME',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
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
                      hintText: 'REASON FOR EXEAT',
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
                      hintText: 'EMERGENCY CONTACT PERSORN',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'EMERGENCY CONTACT NUMBER',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
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
                const SizedBox(height: 20),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff060121)),
                    padding: EdgeInsets.symmetric(
                        horizontal: paddingValue * 1.2,
                        vertical: paddingValue * 0.8),
                    child: Center(
                      child: Text(
                        "SUBMIT REQUEST",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeButton),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.to(() => const HomePage());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
