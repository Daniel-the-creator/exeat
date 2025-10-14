import 'package:exeat_system/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NewExeatForm extends StatefulWidget {
  const NewExeatForm({super.key});

  @override
  State<NewExeatForm> createState() => _NewExeatFormState();
}

class _NewExeatFormState extends State<NewExeatForm> {
  String? selectedApproval;
  final TextEditingController leaveDateController = TextEditingController();
  final TextEditingController leaveTimeController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  final TextEditingController returnTimeController = TextEditingController();

  final List<String> approval = ['APPROVED', 'PENDING', 'DECLINED'];

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectTime(TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        final hour = picked.hour.toString().padLeft(2, '0');
        final minute = picked.minute.toString().padLeft(2, '0');
        controller.text = "$hour:$minute";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double containerWidth =
        screenWidth < 600 ? screenWidth * 0.9 : screenWidth * 0.4;
    double fontSizeTitle = screenWidth < 600 ? 24 : 32;
    double fontSizeSubtitle = screenWidth < 600 ? 14 : 18;
    double fontSizeButton = screenWidth < 600 ? 14 : 18;
    double paddingValue = screenWidth < 600 ? 12 : 20;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => const HomePage()),
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.black87, size: 22),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "New Exeat Form",
                      style: TextStyle(
                        color: const Color(0xff060121),
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeTitle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Fill in the details below to submit your exeat application",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xff060121),
                    fontSize: fontSizeSubtitle,
                  ),
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  "PHONE NUMBER",
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateTimeField(
                        hint: "LEAVE DATE",
                        controller: leaveDateController,
                        onTap: () => _selectDate(leaveDateController),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildDateTimeField(
                        hint: "LEAVE TIME",
                        controller: leaveTimeController,
                        onTap: () => _selectTime(leaveTimeController),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateTimeField(
                        hint: "RETURN DATE",
                        controller: returnDateController,
                        onTap: () => _selectDate(returnDateController),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildDateTimeField(
                        hint: "RETURN TIME",
                        controller: returnTimeController,
                        onTap: () => _selectTime(returnTimeController),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                _buildTextField("REASON FOR EXEAT"),
                const SizedBox(height: 25),
                _buildTextField("EMERGENCY CONTACT PERSON"),
                const SizedBox(height: 25),
                _buildTextField(
                  "EMERGENCY CONTACT NUMBER",
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      value: selectedApproval,
                      isExpanded: true,
                      hint: const Text("Select Guardian approval status"),
                      icon: const Icon(Icons.arrow_drop_down),
                      items: approval.map((String approval) {
                        return DropdownMenuItem<String>(
                          value: approval,
                          child: Text(approval),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedApproval = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.off(() => const HomePage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff060121),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingValue * 1.2,
                      vertical: paddingValue * 0.8,
                    ),
                    child: Center(
                      child: Text(
                        "SUBMIT REQUEST",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeButton,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint, {
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    );
  }

  Widget _buildDateTimeField({
    required String hint,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }
}
