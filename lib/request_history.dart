import 'package:flutter/material.dart';

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
        title: const Column(
          children: [
            Text("Request Details"),
          ],
        ),
        content: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Destination:",style: TextStyle(color:  Color(0xff060121)),), 
            const SizedBox(height: 10,),
            const Text("Abuja",style: TextStyle(color:  Color(0xff060121),fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
                Text("Contact Information:",style: TextStyle(color:  Color(0xff060121)),),
              SizedBox(height: 10,),
              Text("09068149671(Parent)",style: TextStyle(color:  Color(0xff060121),fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("Leave date and time:",style: TextStyle(color:  Color(0xff060121)),),
              SizedBox(height: 10,),
              Text("2025-07-25, 6:00 PM",style: TextStyle(color:  Color(0xff060121),fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
               Text("Return date and time:",style: TextStyle(color:  Color(0xff060121)),),
              SizedBox(height: 10,),
              Text("2025-07-28, 3:00 PM",style: TextStyle(color:  Color(0xff060121),fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
               Text("Reason:",style: TextStyle(color:  Color(0xff060121)),),
              SizedBox(height: 10,),
              Text("Family emergency requesting my presence",style: TextStyle(color:  Color(0xff060121),fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
               Text("Status:",style: TextStyle(color:  Color(0xff060121)),),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.green),
                child: Text("Approved",style: TextStyle(color:  Color(0xff060121),fontWeight: FontWeight.bold),)),
                SizedBox(height: 10,),
               Text("Administrators comment:",style: TextStyle(color:  Color(0xff060121)),),
              SizedBox(height: 10,),
              Text("Request approved, please ensure you submit all course work, safe trip",style: TextStyle(color:  Color(0xff060121),fontWeight: FontWeight.bold),),
              
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth < 600 ? screenWidth * 0.95 : screenWidth * 0.9;
    double fontSizeTitle = screenWidth < 600 ? 24 : 32;
    double paddingValue = screenWidth < 600 ? 12 : 20;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: containerWidth,
            padding: EdgeInsets.all(paddingValue * 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "REQUEST HISTORY",
                  style: TextStyle(
                    color: const Color(0xff060121),
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeTitle,
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    border: TableBorder.all(color: Colors.grey),
                    defaultColumnWidth: const FixedColumnWidth(160),
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(color: Colors.blueGrey),
                        children: [
                          _TableHeaderCell('REQUEST ID'),
                          _TableHeaderCell('DESTINATION'),
                          _TableHeaderCell('LEAVE DATE'),
                          _TableHeaderCell('RETURN DATE'),
                          _TableHeaderCell('STATUS'),
                          _TableHeaderCell('ACTIONS'),
                        ],
                      ),
                      ...tableData.map(
                        (row) => TableRow(
                          children: [
                            _TableTextCell(row['id']!),
                            _TableTextCell(row['destination']!),
                            _TableTextCell(row['leaveDate']!),
                            _TableTextCell(row['returnDate']!),
                            _TableTextCell(row['status']!),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () => _onViewPressed(row['id']!),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: const Text(
                                    'View',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  final String text;
  const _TableHeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _TableTextCell extends StatelessWidget {
  final String text;
  const _TableTextCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
