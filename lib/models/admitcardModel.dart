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

  /// Parse from API response.
  /// The API may return varied field names — handle common variants.
  factory AdmitCardModel.fromJson(Map<String, dynamic> json) {
    return AdmitCardModel(
      schoolName: (json['schoolName'] ?? json['school_name'] ?? 'BENCHMARK')
          .toString(),
      schoolTagline:
          (json['schoolTagline'] ??
                  json['school_tagline'] ??
                  'School of Leadership')
              .toString(),
      schoolSubTagline:
          (json['schoolSubTagline'] ??
                  json['school_sub_tagline'] ??
                  'PLAY GROUP TO MATRIC')
              .toString(),
      examTitle:
          (json['examTitle'] ?? json['exam_title'] ?? json['taskName'] ?? '')
              .toString(),
      studentName:
          (json['studentName'] ?? json['student_name'] ?? json['name'] ?? '')
              .toString(),
      fatherName:
          (json['fatherName'] ??
                  json['father_name'] ??
                  json['fatherName'] ??
                  '')
              .toString(),
      className:
          (json['className'] ?? json['class_name'] ?? json['classDesc'] ?? '')
              .toString(),
      section: (json['section'] ?? '').toString(),
      admissionNo:
          (json['admissionNo'] ??
                  json['admission_no'] ??
                  json['studentId'] ??
                  '')
              .toString(),
      grNo: (json['grNo'] ?? json['gr_no'] ?? '').toString(),
      seatNo: (json['seatNo'] ?? json['seat_no'] ?? json['rollNo'] ?? '')
          .toString(),
      logoUrl: json['logoUrl'] ?? json['logo_url'],
      photoUrl: json['photoUrl'] ?? json['photo_url'] ?? json['pic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schoolName': schoolName,
      'schoolTagline': schoolTagline,
      'schoolSubTagline': schoolSubTagline,
      'examTitle': examTitle,
      'studentName': studentName,
      'fatherName': fatherName,
      'className': className,
      'section': section,
      'admissionNo': admissionNo,
      'grNo': grNo,
      'seatNo': seatNo,
      'logoUrl': logoUrl,
      'photoUrl': photoUrl,
    };
  }
}
