// ignore_for_file: file_names

class AdmitCardModel {
  final String schoolName;
  final String schoolTagline;
  final String schoolSubTagline;
  final String examTitle;

  final String studentName;
  final String fatherName;
  final String className;
  final String section;
  final String admissionNo;
  final String grNo;
  final String seatNo;

  final String? logoUrl;
  final String? photoUrl;

  AdmitCardModel({
    required this.schoolName,
    required this.schoolTagline,
    required this.schoolSubTagline,
    required this.examTitle,
    required this.studentName,
    required this.fatherName,
    required this.className,
    required this.section,
    required this.admissionNo,
    required this.grNo,
    required this.seatNo,
    this.logoUrl,
    this.photoUrl,
  });
}
