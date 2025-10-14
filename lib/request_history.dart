import 'package:exeat_system/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestHistory extends StatefulWidget {
  const RequestHistory({super.key});

  @override
  State<RequestHistory> createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  final List<Map<String, String>> tableData = [
    {
      "id": "001",
      "destination": "Lagos",
      "leaveDate": "08/10/2025",
      "returnDate": "12/10/2025",
      "status": "Approved",
    },
    {
      "id": "002",
      "destination": "Abuja",
      "leaveDate": "15/10/2025",
      "returnDate": "18/10/2025",
      "status": "Pending",
    },
    {
      "id": "003",
      "destination": "Ibadan",
      "leaveDate": "20/10/2025",
      "returnDate": "22/10/2025",
      "status": "Declined",
    },
    {
      "id": "004",
      "destination": "Port Harcourt",
      "leaveDate": "25/10/2025",
      "returnDate": "29/10/2025",
      "status": "Approved",
    },
    {
      "id": "005",
      "destination": "Enugu",
      "leaveDate": "01/11/2025",
      "returnDate": "03/11/2025",
      "status": "Pending",
    },
  ];

  void _onViewPressed(String requestId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Request Details",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff060121)),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _DetailRow(title: "Destination:", value: "Abuja"),
              _DetailRow(
                  title: "Contact Information:", value: "09068149671 (Parent)"),
              _DetailRow(
                  title: "Leave date and time:", value: "2025-07-25, 6:00 PM"),
              _DetailRow(
                  title: "Return date and time:", value: "2025-07-28, 3:00 PM"),
              _DetailRow(
                  title: "Reason:",
                  value: "Family emergency requesting my presence"),
              _StatusBadge(status: "Approved", color: Colors.green),
              _DetailRow(
                  title: "Administrator's comment:",
                  value:
                      "Request approved, please ensure you submit all course work. Safe trip!"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text("Close", style: TextStyle(color: Colors.blueGrey)),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Declined":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double containerWidth =
        screenWidth < 600 ? screenWidth * 0.95 : screenWidth * 0.9;
    double fontSizeTitle = screenWidth < 600 ? 22 : 28;

    return Scaffold(
      backgroundColor: const Color(0xfff7f8fa),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              width: containerWidth,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(() => const HomePage()),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.black87, size: 22),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Request History",
                        style: TextStyle(
                          color: const Color(0xff060121),
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeTitle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Table Cards
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade700,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _HeaderText("ID"),
                              _HeaderText("Destination"),
                              _HeaderText("Leave"),
                              _HeaderText("Return"),
                              _HeaderText("Status"),
                              _HeaderText("Action"),
                            ],
                          ),
                        ),
                        ...tableData.map(
                          (row) => Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _TableText(row['id']!),
                                _TableText(row['destination']!),
                                _TableText(row['leaveDate']!),
                                _TableText(row['returnDate']!),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _statusColor(row['status']!)
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    row['status']!,
                                    style: TextStyle(
                                      color: _statusColor(row['status']!),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () => _onViewPressed(row['id']!),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey.shade700,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 8),
                                  ),
                                  child: const Text(
                                    "View",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
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

class _HeaderText extends StatelessWidget {
  final String text;
  const _HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}

class _TableText extends StatelessWidget {
  final String text;
  const _TableText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xff060121),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String title;
  final String value;
  const _DetailRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$title ",
              style: const TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  final Color color;
  const _StatusBadge({required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style:
            TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
