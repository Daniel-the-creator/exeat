import 'package:get/get.dart';

// Request Model
class ExeatRequest {
  final String id;
  final String studentName;
  final String matricNumber;
  final String destination;
  final String leaveDate;
  final String returnDate;
  final String reason;

  ExeatRequest({
    required this.id,
    required this.studentName,
    required this.matricNumber,
    required this.destination,
    required this.leaveDate,
    required this.returnDate,
    required this.reason,
  });
}

// Request Controller
class RequestAdminController extends GetxController {
  // Observable lists for each status
  var pendingRequests = <ExeatRequest>[].obs;
  var approvedRequests = <ExeatRequest>[].obs;
  var declinedRequests = <ExeatRequest>[].obs;

  // Computed counts
  int get pendingCount => pendingRequests.length;
  int get approvedCount => approvedRequests.length;
  int get declinedCount => declinedRequests.length;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  void _loadInitialData() {
    // Initial pending requests
    pendingRequests.addAll([
      ExeatRequest(
        id: "001",
        studentName: "Fred Daniel",
        matricNumber: "DU0521",
        destination: "Abuja",
        leaveDate: "15/10/2025",
        returnDate: "18/10/2025",
        reason: "Attending family wedding",
      ),
      ExeatRequest(
        id: "002",
        studentName: "Chris Akingbogun",
        matricNumber: "DU0522",
        destination: "Enugu",
        leaveDate: "01/11/2025",
        returnDate: "03/11/2025",
        reason: "Medical appointment",
      ),
      ExeatRequest(
        id: "003",
        studentName: "Fatogun Daniel",
        matricNumber: "DU419",
        destination: "Delta",
        leaveDate: "01/11/2025",
        returnDate: "03/11/2025",
        reason: "Football appointment",
      ),
      ExeatRequest(
        id: "004",
        studentName: "Macfoy Victor",
        matricNumber: "DU0688",
        destination: "Sierra Leone",
        leaveDate: "01/11/2025",
        returnDate: "03/11/2025",
        reason: "To see Anita",
      ),
      ExeatRequest(
        id: "005",
        studentName: "Esuku Matthew",
        matricNumber: "DU0695",
        destination: "Apata",
        leaveDate: "01/11/2025",
        returnDate: "03/11/2025",
        reason: "To see Mercy",
      ),
    ]);

    // Initial approved requests
    approvedRequests.addAll([
      ExeatRequest(
        id: "A001",
        studentName: "Olufemi marvelous",
        matricNumber: "DU0001",
        destination: "Lagos",
        leaveDate: "10/10/2025",
        returnDate: "12/10/2025",
        reason: "Family Visit",
      ),
      ExeatRequest(
        id: "A002",
        studentName: "Fred Daniel",
        matricNumber: "DU0002",
        destination: "Ibadan",
        leaveDate: "11/10/2025",
        returnDate: "13/10/2025",
        reason: "Medical Appointment",
      ),
      ExeatRequest(
        id: "A003",
        studentName: "Adejumo Pelumi",
        matricNumber: "DU0003",
        destination: "Port Harcourt",
        leaveDate: "12/10/2025",
        returnDate: "14/10/2025",
        reason: "Official Leave",
      ),
      ExeatRequest(
        id: "A004",
        studentName: "Mary Adigun",
        matricNumber: "DU0004",
        destination: "Kano",
        leaveDate: "13/10/2025",
        returnDate: "15/10/2025",
        reason: "Personal Errand",
      ),
      ExeatRequest(
        id: "A005",
        studentName: "Chris Akin",
        matricNumber: "DU0005",
        destination: "Calabar",
        leaveDate: "14/10/2025",
        returnDate: "16/10/2025",
        reason: "Health Check",
      ),
      ExeatRequest(
        id: "A006",
        studentName: "chukwu Nonso",
        matricNumber: "DU0006",
        destination: "Jos",
        leaveDate: "15/10/2025",
        returnDate: "17/10/2025",
        reason: "Seminar",
      ),
      ExeatRequest(
        id: "A007",
        studentName: "James Osy",
        matricNumber: "DU0007",
        destination: "Benin",
        leaveDate: "16/10/2025",
        returnDate: "18/10/2025",
        reason: "Home Emergency",
      ),
      ExeatRequest(
        id: "A008",
        studentName: "Fikayo Adejumo",
        matricNumber: "DU0008",
        destination: "Warri",
        leaveDate: "17/10/2025",
        returnDate: "19/10/2025",
        reason: "Travel",
      ),
      ExeatRequest(
        id: "A009",
        studentName: "Sayo Madunwa",
        matricNumber: "DU0009",
        destination: "Abeokuta",
        leaveDate: "18/10/2025",
        returnDate: "20/10/2025",
        reason: "Wedding",
      ),
      ExeatRequest(
        id: "A010",
        studentName: "ofor ebube",
        matricNumber: "DU0010",
        destination: "Ondo",
        leaveDate: "19/10/2025",
        returnDate: "21/10/2025",
        reason: "Medical",
      ),
      ExeatRequest(
        id: "A011",
        studentName: "Ilesanmi Daniel",
        matricNumber: "DU0011",
        destination: "Akure",
        leaveDate: "20/10/2025",
        returnDate: "22/10/2025",
        reason: "Project Research",
      ),
      ExeatRequest(
        id: "A012",
        studentName: "Adebayo mercy",
        matricNumber: "DU0012",
        destination: "Ekiti",
        leaveDate: "21/10/2025",
        returnDate: "23/10/2025",
        reason: "Conference",
      ),
    ]);

    // Initial declined requests
    declinedRequests.addAll([
      ExeatRequest(
        id: "D001",
        studentName: "John osy",
        matricNumber: "DU0101",
        destination: "Unknown",
        leaveDate: "N/A",
        returnDate: "N/A",
        reason: "Incomplete Form",
      ),
      ExeatRequest(
        id: "D002",
        studentName: "Agaga Godwin",
        matricNumber: "DU0102",
        destination: "Unknown",
        leaveDate: "N/A",
        returnDate: "N/A",
        reason: "Exceeded Limit",
      ),
      ExeatRequest(
        id: "D003",
        studentName: "Ademola victor",
        matricNumber: "DU0103",
        destination: "Unknown",
        leaveDate: "N/A",
        returnDate: "N/A",
        reason: "Unauthorized Leave",
      ),
    ]);
  }

  // Approve a pending request
  void approveRequest(ExeatRequest request) {
    pendingRequests.remove(request);
    approvedRequests.add(request);
    Get.snackbar(
      "Success",
      "Request approved for ${request.studentName}",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Get.theme.colorScheme.primary,
      colorText: Get.theme.colorScheme.onPrimary,
      duration: const Duration(seconds: 2),
    );
  }

  // Decline a pending request
  void declineRequest(ExeatRequest request) {
    pendingRequests.remove(request);
    declinedRequests.add(request);
    Get.snackbar(
      "Request Declined",
      "${request.studentName}'s request has been declined",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      duration: const Duration(seconds: 2),
    );
  }
}
