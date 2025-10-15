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

  void _onViewPressed(Map<String, String> request) {
    showDialog(
      context: context,
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isSmallScreen = screenWidth < 600;

        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text(
            "Request Details",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff060121)),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailRow(
                    title: "Destination:", value: request["destination"]!),
                _DetailRow(title: "Leave Date:", value: request["leaveDate"]!),
                _DetailRow(
                    title: "Return Date:", value: request["returnDate"]!),
                const _DetailRow(
                    title: "Reason:",
                    value: "Family emergency requesting my presence."),
                _StatusBadge(
                  status: request["status"]!,
                  color: _statusColor(request["status"]!),
                ),
                const _DetailRow(
                    title: "Admin Comment:",
                    value: "Safe trip, ensure you report on time."),
              ],
            ),
          ),
          actionsAlignment:
              isSmallScreen ? MainAxisAlignment.center : MainAxisAlignment.end,
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  const Text("Close", style: TextStyle(color: Colors.blueGrey)),
            ),
          ],
        );
      },
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
    final isSmallScreen = screenWidth < 700;

    return Scaffold(
      backgroundColor: const Color(0xfff7f8fa),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              width: isSmallScreen ? screenWidth * 0.95 : screenWidth * 0.9,
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
                        "Request History (${tableData.length})",
                        style: TextStyle(
                          color: const Color(0xff060121),
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 22 : 28,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Table/List
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              _HeaderText("ID"),
                              _HeaderText("Destination"),
                              _HeaderText("Leave"),
                              _HeaderText("Return"),
                              _HeaderText("Status"),
                              _HeaderText("Action"),
                            ],
                          ),
                        ),

                        // Data Rows
                        ...tableData.map(
                          (row) => LayoutBuilder(
                            builder: (context, constraints) {
                              if (isSmallScreen) {
                                // Mobile-friendly card layout
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 6),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _DetailRow(
                                          title: "ID:", value: row["id"]!),
                                      _DetailRow(
                                          title: "Destination:",
                                          value: row["destination"]!),
                                      _DetailRow(
                                          title: "Leave Date:",
                                          value: row["leaveDate"]!),
                                      _DetailRow(
                                          title: "Return Date:",
                                          value: row["returnDate"]!),
                                      Row(
                                        children: [
                                          _StatusBadge(
                                            status: row["status"]!,
                                            color: _statusColor(row["status"]!),
                                          ),
                                          const Spacer(),
                                          ElevatedButton(
                                            onPressed: () =>
                                                _onViewPressed(row),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.blueGrey.shade700,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: const Text("View",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // Desktop/table layout
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _TableText(row["id"]!),
                                      _TableText(row["destination"]!),
                                      _TableText(row["leaveDate"]!),
                                      _TableText(row["returnDate"]!),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: _statusColor(row["status"]!)
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          row["status"]!,
                                          style: TextStyle(
                                            color: _statusColor(row["status"]!),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => _onViewPressed(row),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.blueGrey.shade700,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                );
                              }
                            },
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
      padding: const EdgeInsets.only(bottom: 8),
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
      margin: const EdgeInsets.only(top: 5, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style:
            TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );
  }
}
