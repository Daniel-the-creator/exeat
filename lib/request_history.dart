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
      "reason": "Family emergency requesting my presence.",
    },
    {
      "id": "002",
      "destination": "Abuja",
      "leaveDate": "15/10/2025",
      "returnDate": "18/10/2025",
      "status": "Pending",
      "reason": "Attending family wedding ceremony.",
    },
    {
      "id": "003",
      "destination": "Ibadan",
      "leaveDate": "20/10/2025",
      "returnDate": "22/10/2025",
      "status": "Declined",
      "reason": "Medical appointment with specialist.",
    },
    {
      "id": "004",
      "destination": "Port Harcourt",
      "leaveDate": "25/10/2025",
      "returnDate": "29/10/2025",
      "status": "Approved",
      "reason": "Religious obligation and family gathering.",
    },
    {
      "id": "005",
      "destination": "Enugu",
      "leaveDate": "01/11/2025",
      "returnDate": "03/11/2025",
      "status": "Pending",
      "reason": "Important family event requiring attendance.",
    },
  ];

  void _onViewPressed(Map<String, String> request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text(
          "Request Details",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff060121)),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailRow(title: "Request ID:", value: request["id"]!),
              _DetailRow(title: "Destination:", value: request["destination"]!),
              _DetailRow(title: "Leave Date:", value: request["leaveDate"]!),
              _DetailRow(title: "Return Date:", value: request["returnDate"]!),
              _DetailRow(title: "Reason:", value: request["reason"]!),
              const SizedBox(height: 12),
              _StatusBadge(
                status: request["status"]!,
                color: _statusColor(request["status"]!),
              ),
              const SizedBox(height: 12),
              const _DetailRow(
                title: "Admin Comment:",
                value: "Safe trip, ensure you report on time.",
              ),
            ],
          ),
        ),
        actionsPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
    final screenW = MediaQuery.of(context).size.width;
    final isSmall = screenW < 800;
    final horizontalPadding = isSmall ? 12.0 : 32.0;
    final contentWidth = isSmall ? screenW - (horizontalPadding * 2) : 1000.0;
    final titleSize = isSmall ? 20.0 : 26.0;
    final headerIconSize = isSmall ? 20.0 : 24.0;

    return Scaffold(
      backgroundColor: const Color(0xfff7f8fa),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => const HomePage()),
                    child: Icon(Icons.arrow_back_ios_new,
                        size: headerIconSize, color: Colors.black87),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Request History (${tableData.length})",
                      style: TextStyle(
                          color: const Color(0xff060121),
                          fontWeight: FontWeight.bold,
                          fontSize: titleSize),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Content card
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 4))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: isSmall ? _buildListView() : _buildTableView(),
                      ),
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

  // Mobile: stacked cards
  Widget _buildListView() {
    return ListView.separated(
      itemCount: tableData.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      padding: EdgeInsets.zero,
      itemBuilder: (context, idx) {
        final row = tableData[idx];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(row['id']!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(row['destination']!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    _StatusBadge(
                      status: row["status"]!,
                      color: _statusColor(row["status"]!),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text("Leave: ${row['leaveDate']}"),
                Text("Return: ${row['returnDate']}"),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _onViewPressed(row),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.blueGrey.shade700),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("View Details"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Desktop/tablet: table-like rows
  Widget _buildTableView() {
    return Column(
      children: [
        // Header row
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
              borderRadius: BorderRadius.circular(8)),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(flex: 1, child: Center(child: _HeaderText("ID"))),
              Flexible(
                  flex: 3, child: Center(child: _HeaderText("Destination"))),
              Flexible(flex: 2, child: Center(child: _HeaderText("Leave"))),
              Flexible(flex: 2, child: Center(child: _HeaderText("Return"))),
              Flexible(flex: 2, child: Center(child: _HeaderText("Status"))),
              Flexible(flex: 2, child: Center(child: _HeaderText("Action"))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.separated(
            itemCount: tableData.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, idx) {
              final row = tableData[idx];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                        flex: 1, child: Center(child: _TableText(row['id']!))),
                    Flexible(
                        flex: 3,
                        child: Center(child: _TableText(row['destination']!))),
                    Flexible(
                        flex: 2,
                        child: Center(child: _TableText(row['leaveDate']!))),
                    Flexible(
                        flex: 2,
                        child: Center(child: _TableText(row['returnDate']!))),
                    Flexible(
                      flex: 2,
                      child: Center(
                        child: _StatusBadge(
                          status: row["status"]!,
                          color: _statusColor(row["status"]!),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () => _onViewPressed(row),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey.shade700,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("View",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ---------- Supporting widgets ----------

class _HeaderText extends StatelessWidget {
  final String text;
  const _HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
  }
}

class _TableText extends StatelessWidget {
  final String text;
  const _TableText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Color(0xff060121), fontWeight: FontWeight.w500));
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
                    color: Colors.black87, fontWeight: FontWeight.w700)),
            TextSpan(
                text: value, style: const TextStyle(color: Colors.black54)),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8)),
      child: Text(status,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}
