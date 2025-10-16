import 'package:exeat_system/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingRequests extends StatefulWidget {
  const PendingRequests({super.key});

  @override
  State<PendingRequests> createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  final List<Map<String, String>> pendingData = [
    {
      "id": "001",
      "student": "Fred Daniel",
      "destination": "Abuja",
      "leaveDate": "15/10/2025",
      "returnDate": "18/10/2025",
      "reason": "Attending family wedding",
    },
    {
      "id": "002",
      "student": "Chris Akingbogun",
      "destination": "Enugu",
      "leaveDate": "01/11/2025",
      "returnDate": "03/11/2025",
      "reason": "Medical appointment",
    },
    {
      "id": "003",
      "student": "Ayo Samuel",
      "destination": "Delta",
      "leaveDate": "01/11/2025",
      "returnDate": "03/11/2025",
      "reason": "Football appointment",
    },
    {
      "id": "004",
      "student": "Macfoy Victor",
      "destination": "Sierra Leone",
      "leaveDate": "01/11/2025",
      "returnDate": "03/11/2025",
      "reason": "To see Anita",
    },
    {
      "id": "005",
      "student": "Esuku Matthew",
      "destination": "Apata",
      "leaveDate": "01/11/2025",
      "returnDate": "03/11/2025",
      "reason": "To see Mercy",
    },
  ];

  void _onViewPressed(Map<String, String> request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text(
          "Pending Request Details",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff060121)),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailRow(title: "Student Name:", value: request["student"]!),
              _DetailRow(title: "Destination:", value: request["destination"]!),
              _DetailRow(title: "Leave Date:", value: request["leaveDate"]!),
              _DetailRow(title: "Return Date:", value: request["returnDate"]!),
              _DetailRow(title: "Reason:", value: request["reason"]!),
              const SizedBox(height: 12),
              const _StatusBadge(status: "Pending", color: Colors.orange),
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.check, size: 18),
                label: const Text("Approve"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Request Approved"),
                        backgroundColor: Colors.green),
                  );
                },
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.close, size: 18),
                label: const Text("Decline"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Request Declined"),
                        backgroundColor: Colors.redAccent),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final isSmall = screenW < 800; // threshold for switching layout
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
              // header row
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => const AdminDashboard()),
                    child: Icon(Icons.arrow_back_ios_new,
                        size: headerIconSize, color: Colors.black87),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Pending Requests (${pendingData.length})",
                      style: TextStyle(
                          color: const Color(0xff060121),
                          fontWeight: FontWeight.bold,
                          fontSize: titleSize),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // content card
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

  // mobile: stacked cards
  Widget _buildListView() {
    return ListView.separated(
      itemCount: pendingData.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      padding: EdgeInsets.zero,
      itemBuilder: (context, idx) {
        final row = pendingData[idx];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      child: Text(row['student']!,
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
              const SizedBox(height: 8),
              Text("Destination: ${row['destination']}"),
              Text("Leave: ${row['leaveDate']}"),
              Text("Return: ${row['returnDate']}"),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _onViewPressed(row),
                      child: const Text("View Details"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // quick approve action (example)
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Approved"),
                          backgroundColor: Colors.green));
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Approve"),
                  ),
                ],
              ),
            ]),
          ),
        );
      },
    );
  }

  // desktop/tablet: table-like rows
  Widget _buildTableView() {
    return Column(
      children: [
        // header row
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
              borderRadius: BorderRadius.circular(8)),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(flex: 1, child: Center(child: _HeaderText("ID"))),
              Flexible(flex: 3, child: Center(child: _HeaderText("Student"))),
              Flexible(
                  flex: 3, child: Center(child: _HeaderText("Destination"))),
              Flexible(flex: 2, child: Center(child: _HeaderText("Leave"))),
              Flexible(flex: 2, child: Center(child: _HeaderText("Return"))),
              Flexible(flex: 2, child: Center(child: _HeaderText("Action"))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.separated(
            itemCount: pendingData.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, idx) {
              final row = pendingData[idx];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                        flex: 1, child: Center(child: _TableText(row['id']!))),
                    Flexible(
                        flex: 3,
                        child: Center(child: _TableText(row['student']!))),
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

// ---------- small supporting widgets ----------

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
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}
