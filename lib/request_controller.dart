// request_controller.dart
import 'package:exeat_system/request_model.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  var requests = <ExeatRequest>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Add some sample data
    requests.addAll([
      ExeatRequest(
        id: "001",
        destination: "Lagos",
        leaveDate: "08/10/2025",
        returnDate: "12/10/2025",
        leaveTime: "08:00",
        returnTime: "18:00",
        status: "Approved",
        reason: "Family emergency requesting my presence.",
        phone: "08012345678",
        contactPerson: "John Doe",
        contactNumber: "08087654321",
        guardianApproval: "APPROVED",
        submittedAt: DateTime(2025, 10, 1),
      ),
    ]);
  }

  void addRequest(ExeatRequest newRequest) {
    requests.insert(0, newRequest); // Add to beginning for newest first
  }

  String generateNewId() {
    if (requests.isEmpty) return "001";
    final lastId = int.parse(requests.first.id);
    return (lastId + 1).toString().padLeft(3, '0');
  }

  List<Map<String, String>> getTableData() {
    return requests.map((request) => request.toTableData()).toList();
  }
}
