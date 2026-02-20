import 'package:get/get.dart';
import 'package:school_management_system/models/admitcardModel.dart';


class AdmitCardController extends GetxController {
  final isLoading = false.obs;
  final isGeneratingPdf = false.obs;
  final admitCard = Rxn<AdmitCardModel>();

  @override
  void onInit() {
    super.onInit();
    loadAdmitCard();
  }

  Future<void> loadAdmitCard() async {
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 400));

    admitCard.value = AdmitCardModel(
      schoolName: "BENCHMARK",
      schoolTagline: "School of Leadership",
      schoolSubTagline: "PLAY GROUP TO MATRIC",
      examTitle: "Preliminary Test (Spring) Examination 2025 - 26",
      studentName: "EMAN FATIMA",
      fatherName: "RAFI KHAN",
      className: "GRADE I",
      section: "A",
      admissionNo: "58",
      grNo: "058",
      seatNo: "1",
      logoUrl: null,
      photoUrl: null,
    );

    isLoading.value = false;
  }
}
