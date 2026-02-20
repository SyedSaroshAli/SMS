
class MarksheetModel {
  final StudentInfo studentInfo;
  final String session;
  final String taskName;
  final List<SubjectMark> subjects;
  final DateTime? createdAt;
  final String? schoolLogo;
  final String? schoolName;
  final String? schoolTagline;

  MarksheetModel({
    required this.studentInfo,
    required this.session,
    required this.taskName,
    required this.subjects,
    this.createdAt,
    this.schoolLogo,
    this.schoolName,
    this.schoolTagline,
  });

  factory MarksheetModel.fromJson(Map<String, dynamic> json) {
    return MarksheetModel(
      studentInfo: StudentInfo.fromJson(json['studentInfo'] ?? {}),
      session: json['session'] ?? '',
      taskName: json['taskName'] ?? '',
      subjects: (json['subjects'] as List<dynamic>?)
              ?.map((subject) => SubjectMark.fromJson(subject))
              .toList() ??
          [],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      schoolLogo: json['schoolLogo'],
      schoolName: json['schoolName'],
      schoolTagline: json['schoolTagline'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentInfo': studentInfo.toJson(),
      'session': session,
      'taskName': taskName,
      'subjects': subjects.map((subject) => subject.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'schoolLogo': schoolLogo,
      'schoolName': schoolName,
      'schoolTagline': schoolTagline,
    };
  }

  MarksheetModel copyWith({
    StudentInfo? studentInfo,
    String? session,
    String? taskName,
    List<SubjectMark>? subjects,
    DateTime? createdAt,
    String? schoolLogo,
    String? schoolName,
    String? schoolTagline,
  }) {
    return MarksheetModel(
      studentInfo: studentInfo ?? this.studentInfo,
      session: session ?? this.session,
      taskName: taskName ?? this.taskName,
      subjects: subjects ?? this.subjects,
      createdAt: createdAt ?? this.createdAt,
      schoolLogo: schoolLogo ?? this.schoolLogo,
      schoolName: schoolName ?? this.schoolName,
      schoolTagline: schoolTagline ?? this.schoolTagline,
    );
  }
}

/// Student Information Model
class StudentInfo {
  final String studentId;
  final String name;
  final String fatherName;
  final String rollNumber;
  final String grade;
  final String result;
  final String resultStatus;
  final double totalMarks;
  final double obtainedMarks;
  final String percentage;
  final String remarks;
  final String remarksGrade;
  final String? photoUrl;

  StudentInfo({
    required this.studentId,
    required this.name,
    required this.fatherName,
    required this.rollNumber,
    required this.grade,
    required this.result,
    required this.resultStatus,
    required this.totalMarks,
    required this.obtainedMarks,
    required this.percentage,
    required this.remarks,
    required this.remarksGrade,
    this.photoUrl,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) {
    return StudentInfo(
      studentId: json['studentId'] ?? '',
      name: json['name'] ?? '',
      fatherName: json['fatherName'] ?? '',
      rollNumber: json['rollNumber'] ?? '',
      grade: json['grade'] ?? '',
      result: json['result'] ?? '',
      resultStatus: json['resultStatus'] ?? '',
      totalMarks: (json['totalMarks'] ?? 0).toDouble(),
      obtainedMarks: (json['obtainedMarks'] ?? 0).toDouble(),
      percentage: json['percentage'] ?? '',
      remarks: json['remarks'] ?? '',
      remarksGrade: json['remarksGrade'] ?? '',
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'name': name,
      'fatherName': fatherName,
      'rollNumber': rollNumber,
      'grade': grade,
      'result': result,
      'resultStatus': resultStatus,
      'totalMarks': totalMarks,
      'obtainedMarks': obtainedMarks,
      'percentage': percentage,
      'remarks': remarks,
      'remarksGrade': remarksGrade,
      'photoUrl': photoUrl,
    };
  }

  StudentInfo copyWith({
    String? studentId,
    String? name,
    String? fatherName,
    String? rollNumber,
    String? grade,
    String? result,
    String? resultStatus,
    double? totalMarks,
    double? obtainedMarks,
    String? percentage,
    String? remarks,
    String? remarksGrade,
    String? photoUrl,
  }) {
    return StudentInfo(
      studentId: studentId ?? this.studentId,
      name: name ?? this.name,
      fatherName: fatherName ?? this.fatherName,
      rollNumber: rollNumber ?? this.rollNumber,
      grade: grade ?? this.grade,
      result: result ?? this.result,
      resultStatus: resultStatus ?? this.resultStatus,
      totalMarks: totalMarks ?? this.totalMarks,
      obtainedMarks: obtainedMarks ?? this.obtainedMarks,
      percentage: percentage ?? this.percentage,
      remarks: remarks ?? this.remarks,
      remarksGrade: remarksGrade ?? this.remarksGrade,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}

/// Subject Mark Model
class SubjectMark {
  final String subjectId;
  final String subjectName;
  final double maximumMarks;
  final double passingMarks;
  final double obtainedMarks;
  final String? grade;
  final bool isPassed;

  SubjectMark({
    required this.subjectId,
    required this.subjectName,
    required this.maximumMarks,
    required this.passingMarks,
    required this.obtainedMarks,
    this.grade,
    bool? isPassed,
  }) : isPassed = isPassed ?? (obtainedMarks >= passingMarks);

  factory SubjectMark.fromJson(Map<String, dynamic> json) {
    final obtainedMarks = (json['obtainedMarks'] ?? 0).toDouble();
    final passingMarks = (json['passingMarks'] ?? 0).toDouble();

    return SubjectMark(
      subjectId: json['subjectId'] ?? '',
      subjectName: json['subjectName'] ?? '',
      maximumMarks: (json['maximumMarks'] ?? 0).toDouble(),
      passingMarks: passingMarks,
      obtainedMarks: obtainedMarks,
      grade: json['grade'],
      isPassed: json['isPassed'] ?? (obtainedMarks >= passingMarks),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'subjectName': subjectName,
      'maximumMarks': maximumMarks,
      'passingMarks': passingMarks,
      'obtainedMarks': obtainedMarks,
      'grade': grade,
      'isPassed': isPassed,
    };
  }

  SubjectMark copyWith({
    String? subjectId,
    String? subjectName,
    double? maximumMarks,
    double? passingMarks,
    double? obtainedMarks,
    String? grade,
    bool? isPassed,
  }) {
    return SubjectMark(
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      maximumMarks: maximumMarks ?? this.maximumMarks,
      passingMarks: passingMarks ?? this.passingMarks,
      obtainedMarks: obtainedMarks ?? this.obtainedMarks,
      grade: grade ?? this.grade,
      isPassed: isPassed ?? this.isPassed,
    );
  }

  double get percentage => (obtainedMarks / maximumMarks) * 100;
}

/// Filter Option Model
class FilterOption {
  final String id;
  final String name;
  final dynamic value;

  FilterOption({
    required this.id,
    required this.name,
    this.value,
  });

  factory FilterOption.fromJson(Map<String, dynamic> json) {
    return FilterOption(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterOption &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}