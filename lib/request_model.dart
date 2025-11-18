// request_model.dart
class ExeatRequest {
  final String id;
  final String destination;
  final String leaveDate;
  final String returnDate;
  final String leaveTime;
  final String returnTime;
  final String status;
  final String reason;
  final String phone;
  final String contactPerson;
  final String contactNumber;
  final String guardianApproval;
  final DateTime submittedAt;

  ExeatRequest({
    required this.id,
    required this.destination,
    required this.leaveDate,
    required this.returnDate,
    required this.leaveTime,
    required this.returnTime,
    required this.status,
    required this.reason,
    required this.phone,
    required this.contactPerson,
    required this.contactNumber,
    required this.guardianApproval,
    required this.submittedAt,
  });

  Map<String, String> toTableData() {
    return {
      "id": id,
      "destination": destination,
      "leaveDate": leaveDate,
      "returnDate": returnDate,
      "status": status,
      "reason": reason,
    };
  }
}
