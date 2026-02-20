/// Models for Student Fee Module
/// API-ready: use fromMap/toMap for JSON serialization

// ignore_for_file: dangling_library_doc_comments

enum FeeType {
  monthly,
  yearly;

  String get displayName => this == FeeType.monthly ? 'Monthly' : 'Yearly';
}

class StudentFeeModel {
  final String studentId;
  final String studentName;
  final String department;
  final double tuitionFee;
  final String? imageUrl;

  StudentFeeModel({
    required this.studentId,
    required this.studentName,
    required this.department,
    required this.tuitionFee,
    this.imageUrl,
  });

  factory StudentFeeModel.fromMap(Map<String, dynamic> map) {
    return StudentFeeModel(
      studentId: (map['student_id'] ?? map['studentId'] ?? '').toString(),
      studentName: (map['student_name'] ?? map['studentName'] ?? '').toString(),
      department: (map['department'] ?? '').toString(),
      tuitionFee: (map['tuition_fee'] ?? map['tuitionFee'] ?? 0.0).toDouble(),
      imageUrl: map['image_url'] ?? map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'student_id': studentId,
      'student_name': studentName,
      'department': department,
      'tuition_fee': tuitionFee,
      'image_url': imageUrl,
    };
  }
}

class FeeRecord {
  final String id;
  final String year;
  final String month;
  final String details;
  final double amount;
  final DateTime feeDate;
  final String receiptNo;
  final int unpaidMonths;

  FeeRecord({
    required this.id,
    required this.year,
    required this.month,
    required this.details,
    required this.amount,
    required this.feeDate,
    required this.receiptNo,
    this.unpaidMonths = 0,
  });

  factory FeeRecord.fromMap(Map<String, dynamic> map) {
    final feeDate = map['fee_date'] ?? map['feeDate'];
    return FeeRecord(
      id: (map['id'] ?? '').toString(),
      year: (map['year'] ?? '').toString(),
      month: (map['month'] ?? '').toString(),
      details: (map['details'] ?? '').toString(),
      amount: (map['amount'] ?? map['fee_amount'] ?? 0.0).toDouble(),
      feeDate: feeDate is DateTime
          ? feeDate
          : DateTime.tryParse(feeDate?.toString() ?? '') ?? DateTime.now(),
      receiptNo: (map['receipt_no'] ?? map['receiptNo'] ?? '').toString(),
      unpaidMonths: (map['unpaid_months'] ?? map['unpaidMonths'] ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'year': year,
      'month': month,
      'details': details,
      'amount': amount,
      'fee_date': feeDate.toIso8601String(),
      'receipt_no': receiptNo,
      'unpaid_months': unpaidMonths,
    };
  }
}

class FeeSearchFilter {
  final String year;
  final String month;
  final FeeType feeType;

  FeeSearchFilter({
    this.year = '',
    this.month = '',
    this.feeType = FeeType.monthly,
  });

  FeeSearchFilter copyWith({
    String? year,
    String? month,
    FeeType? feeType,
  }) {
    return FeeSearchFilter(
      year: year ?? this.year,
      month: month ?? this.month,
      feeType: feeType ?? this.feeType,
    );
  }
}

/// Summary for display (unpaid count, total paid, etc.)
class StudentFeeSummary {
  final StudentFeeModel student;
  final List<String> unpaidMonths;
  final List<FeeRecord> paidFees;
  final double totalPaid;

  StudentFeeSummary({
    required this.student,
    required this.unpaidMonths,
    required this.paidFees,
    required this.totalPaid,
  });
}
