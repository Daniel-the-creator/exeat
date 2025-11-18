import 'package:exeat_system/home_page.dart';
import 'package:exeat_system/request_controller.dart';
import 'package:exeat_system/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NewExeatForm extends StatefulWidget {
  const NewExeatForm({super.key});

  @override
  State<NewExeatForm> createState() => _NewExeatFormState();
}

class _NewExeatFormState extends State<NewExeatForm>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final RequestController _requestController = Get.find<RequestController>();

  String? selectedApproval;
  String? selectedDestination;
  final TextEditingController leaveDateController = TextEditingController();
  final TextEditingController leaveTimeController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  final TextEditingController returnTimeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  final List<String> approval = ['APPROVED', 'PENDING', 'DECLINED'];
  final List<String> destinations = [
    'Lagos',
    'Abuja',
    'Ibadan',
    'Port Harcourt',
    'Enugu',
    'Kano',
    'Kaduna',
    'Benin',
    'Warri',
    'Calabar'
  ];
  bool _isSubmitting = false;

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
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    leaveDateController.dispose();
    leaveTimeController.dispose();
    returnDateController.dispose();
    returnTimeController.dispose();
    phoneController.dispose();
    reasonController.dispose();
    contactPersonController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff060121),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
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
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff060121),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        final hour = picked.hour.toString().padLeft(2, '0');
        final minute = picked.minute.toString().padLeft(2, '0');
        controller.text = "$hour:$minute";
      });
    }
  }

  Future<void> _submitForm() async {
    if (_validateForm()) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Create new request
      final newRequest = ExeatRequest(
        id: _requestController.generateNewId(),
        destination: selectedDestination!,
        leaveDate: leaveDateController.text,
        returnDate: returnDateController.text,
        leaveTime: leaveTimeController.text,
        returnTime: returnTimeController.text,
        status: "Pending", // All new requests start as pending
        reason: reasonController.text,
        phone: phoneController.text,
        contactPerson: contactPersonController.text,
        contactNumber: contactNumberController.text,
        guardianApproval: selectedApproval!,
        submittedAt: DateTime.now(),
      );

      // Add to controller
      _requestController.addRequest(newRequest);

      setState(() {
        _isSubmitting = false;
      });

      // Show success dialog
      _showSuccessDialog();
    }
  }

  bool _validateForm() {
    if (phoneController.text.isEmpty ||
        selectedDestination == null ||
        leaveDateController.text.isEmpty ||
        leaveTimeController.text.isEmpty ||
        returnDateController.text.isEmpty ||
        returnTimeController.text.isEmpty ||
        reasonController.text.isEmpty ||
        contactPersonController.text.isEmpty ||
        contactNumberController.text.isEmpty ||
        selectedApproval == null) {
      _showSnackBar('Please fill in all fields');
      return false;
    }
    return true;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[400],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                Color(0xff060121),
                Color(0xff2d1b5e),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 20),
              const Text(
                'Request Submitted!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your exeat request has been submitted successfully\nand will appear in your request history.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog first
                    Get.off(() => const HomePage());
                  },
                  child: const Text(
                    'BACK TO HOME',
                    style: TextStyle(
                      color: Color(0xff060121),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double containerWidth =
        screenWidth < 600 ? screenWidth * 0.9 : screenWidth * 0.4;
    double fontSizeTitle = screenWidth < 600 ? 28 : 36;
    double fontSizeSubtitle = screenWidth < 600 ? 14 : 16;
    double fontSizeButton = screenWidth < 600 ? 14 : 16;
    double paddingValue = screenWidth < 600 ? 16 : 24;

    return Scaffold(
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
              physics: const BouncingScrollPhysics(),
              child: Center(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with back button
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xff060121).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Color(0xff060121),
                                  size: 20),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "NEW EXEAT REQUEST",
                                  style: TextStyle(
                                    color: const Color(0xff060121),
                                    fontWeight: FontWeight.w900,
                                    fontSize: fontSizeTitle,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Fill in the details below to submit your exeat application",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: fontSizeSubtitle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Form Fields
                      _buildTextField(
                        "PHONE NUMBER",
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        icon: Icons.phone_rounded,
                      ),
                      const SizedBox(height: 20),

                      // Destination Dropdown
                      _buildDestinationDropdown(),
                      const SizedBox(height: 20),

                      // Date and Time Row
                      Text(
                        "DEPARTURE",
                        style: TextStyle(
                          color: const Color(0xff060121),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDateTimeField(
                              hint: "SELECT DATE",
                              controller: leaveDateController,
                              onTap: () => _selectDate(leaveDateController),
                              icon: Icons.calendar_today_rounded,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildDateTimeField(
                              hint: "SELECT TIME",
                              controller: leaveTimeController,
                              onTap: () => _selectTime(leaveTimeController),
                              icon: Icons.access_time_rounded,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Return Date and Time
                      Text(
                        "RETURN",
                        style: TextStyle(
                          color: const Color(0xff060121),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDateTimeField(
                              hint: "SELECT DATE",
                              controller: returnDateController,
                              onTap: () => _selectDate(returnDateController),
                              icon: Icons.calendar_today_rounded,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildDateTimeField(
                              hint: "SELECT TIME",
                              controller: returnTimeController,
                              onTap: () => _selectTime(returnTimeController),
                              icon: Icons.access_time_rounded,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildTextField(
                        "REASON FOR EXEAT",
                        controller: reasonController,
                        icon: Icons.description_rounded,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),

                      _buildTextField(
                        "EMERGENCY CONTACT PERSON",
                        controller: contactPersonController,
                        icon: Icons.person_rounded,
                      ),
                      const SizedBox(height: 20),

                      _buildTextField(
                        "EMERGENCY CONTACT NUMBER",
                        controller: contactNumberController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        icon: Icons.contact_phone_rounded,
                      ),
                      const SizedBox(height: 20),

                      // Guardian Approval Dropdown
                      _buildGuardianDropdown(),
                      const SizedBox(height: 32),

                      // Submit Button
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: _isSubmitting
                              ? null
                              : const LinearGradient(
                                  colors: [
                                    Color(0xff060121),
                                    Color(0xff2d1b5e),
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: _isSubmitting
                              ? null
                              : [
                                  BoxShadow(
                                    color: const Color(0xff060121)
                                        .withOpacity(0.4),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _isSubmitting ? null : _submitForm,
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: paddingValue * 0.9,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_isSubmitting)
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  else
                                    const Icon(
                                      Icons.send_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  const SizedBox(width: 10),
                                  Text(
                                    _isSubmitting
                                        ? "SUBMITTING..."
                                        : "SUBMIT REQUEST",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSizeButton + 2,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
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
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint, {
    required TextEditingController controller,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1.5),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(icon, color: const Color(0xff060121)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeField({
    required String hint,
    required TextEditingController controller,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1.5),
      ),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(icon, color: const Color(0xff060121)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildDestinationDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedDestination,
          isExpanded: true,
          hint: Text(
            "SELECT DESTINATION",
            style: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: Icon(Icons.arrow_drop_down_rounded,
              color: const Color(0xff060121)),
          items: destinations.map((String destination) {
            return DropdownMenuItem<String>(
              value: destination,
              child: Text(
                destination,
                style: const TextStyle(
                  color: Color(0xff060121),
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedDestination = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildGuardianDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedApproval,
          isExpanded: true,
          hint: Text(
            "GUARDIAN APPROVAL STATUS",
            style: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: Icon(Icons.arrow_drop_down_rounded,
              color: const Color(0xff060121)),
          items: approval.map((String approval) {
            return DropdownMenuItem<String>(
              value: approval,
              child: Text(
                approval,
                style: const TextStyle(
                  color: Color(0xff060121),
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedApproval = newValue!;
            });
          },
        ),
      ),
    );
  }
}
