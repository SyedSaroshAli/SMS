// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:school_management_system/models/singleMarksheetModel.dart';


class MarksheetController extends GetxController {
  // Observable variables
  final isLoading = false.obs;
  final isGeneratingPdf = false.obs;
  final isFilterExpanded = false.obs;
  final selectedYear = Rx<FilterOption?>(null);
  final selectedTask = Rx<FilterOption?>(null);
  final selectedSubject = Rx<FilterOption?>(null);
  final marksheet = Rx<MarksheetModel?>(null);

  // Filter options
  final yearOptions = <FilterOption>[].obs;
  final taskOptions = <FilterOption>[].obs;
  final subjectOptions = <FilterOption>[].obs;

  // Dependencies (inject when API is ready)
  // final ApiService _apiService = Get.find<ApiService>();

  @override
  void onInit() {
    super.onInit();
    _initializeFilters();
  }

  /// Initialize filter options with dummy data
  void _initializeFilters() {
    // Year options
    yearOptions.value = [
      FilterOption(id: '1', name: '2024-2025'),
      FilterOption(id: '2', name: '2023-2024'),
      FilterOption(id: '3', name: '2022-2023'),
    ];

    // Task options
    taskOptions.value = [
      FilterOption(id: '1', name: 'Preliminary Test'),
      FilterOption(id: '2', name: 'Mid Term Exam'),
      FilterOption(id: '3', name: 'Final Exam'),
      FilterOption(id: '4', name: 'Unit Test 1'),
      FilterOption(id: '5', name: 'Unit Test 2'),
    ];

    // Subject options
    subjectOptions.value = [
      FilterOption(id: '0', name: 'All Subjects'),
      FilterOption(id: '1', name: 'ISLAMIAT'),
      FilterOption(id: '2', name: 'URDU'),
      FilterOption(id: '3', name: 'ENGLISH'),
      FilterOption(id: '4', name: 'MATHEMATICS'),
      FilterOption(id: '5', name: 'SCIENCE'),
      FilterOption(id: '6', name: 'SOCIAL STUDIES'),
      FilterOption(id: '7', name: 'ICT'),
      FilterOption(id: '8', name: 'HEALTH'),
      FilterOption(id: '9', name: 'ASSIGNMENT & CLASSROOM ACTIVITY'),
    ];

    // Set default selections
    selectedYear.value = yearOptions.first;
    selectedTask.value = taskOptions.first;
    selectedSubject.value = subjectOptions.first;

    // Load initial marksheet
    loadMarksheet();
  }

  /// Load marksheet based on selected filters
  Future<void> loadMarksheet() async {
    try {
      isLoading.value = true;

      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

     
      // final response = await _apiService.getMarksheet(
      //   year: selectedYear.value?.id,
      //   taskId: selectedTask.value?.id,
      //   subjectId: selectedSubject.value?.id,
      // );
      // marksheet.value = MarksheetModel.fromJson(response);

      // Using dummy data for now
      marksheet.value = _getDummyMarksheet();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load marksheet: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Generate dummy marksheet data
  MarksheetModel _getDummyMarksheet() {
    final filteredSubjects = _getFilteredSubjects();

    // Calculate totals
    double totalMax = 0;
    double totalObtained = 0;
    for (var subject in filteredSubjects) {
      totalMax += subject.maximumMarks;
      totalObtained += subject.obtainedMarks;
    }

    final percentage = totalMax > 0 ? (totalObtained / totalMax * 100) : 0;

    return MarksheetModel(
      studentInfo: StudentInfo(
        studentId: 'STD001',
        name: 'AMANDA IRSHAAD',
        fatherName: 'IRSHAAD MAJEED',
        rollNumber: '45',
        grade: 'VIII',
        result: 'TRY AGAIN',
        resultStatus: 'Retake Exams',
        totalMarks: totalMax,
        obtainedMarks: totalObtained,
        percentage: '${percentage.toStringAsFixed(2)} %',
        remarks: 'MINOR SETBACK',
        remarksGrade: 'A+',
        photoUrl: null,
      ),
      session: 'SESSION 2024 - 2025 (FALL)',
      taskName: 'MARKSHEET FOR ${selectedTask.value?.name.toUpperCase() ?? 'TEST'}',
      subjects: filteredSubjects,
      createdAt: DateTime.now(),
      schoolName: 'BENCHMARK School of Leadership',
      schoolTagline: 'PLAY GROUP TO O\' MATRIC',
    );
  }

  /// Get filtered subjects based on selection
  List<SubjectMark> _getFilteredSubjects() {
    final allSubjects = [
      SubjectMark(
        subjectId: '1',
        subjectName: 'ISLAMIAT',
        maximumMarks: 25.00,
        passingMarks: 10.00,
        obtainedMarks: 25.00,
      ),
      SubjectMark(
        subjectId: '2',
        subjectName: 'URDU',
        maximumMarks: 25.00,
        passingMarks: 10.00,
        obtainedMarks: 25.00,
      ),
      SubjectMark(
        subjectId: '3',
        subjectName: 'ENGLISH',
        maximumMarks: 25.00,
        passingMarks: 10.00,
        obtainedMarks: 24.00,
      ),
      SubjectMark(
        subjectId: '4',
        subjectName: 'MATHEMATICS',
        maximumMarks: 25.00,
        passingMarks: 10.00,
        obtainedMarks: 24.00,
      ),
      SubjectMark(
        subjectId: '5',
        subjectName: 'SCIENCE',
        maximumMarks: 25.00,
        passingMarks: 10.00,
        obtainedMarks: 25.00,
      ),
      SubjectMark(
        subjectId: '6',
        subjectName: 'SOCIAL STUDIES',
        maximumMarks: 25.00,
        passingMarks: 10.00,
        obtainedMarks: 24.00,
      ),
      SubjectMark(
        subjectId: '7',
        subjectName: 'ICT',
        maximumMarks: 25.00,
        passingMarks: 10.00,
        obtainedMarks: 24.00,
      ),
      SubjectMark(
        subjectId: '8',
        subjectName: 'HEALTH',
        maximumMarks: 25.00,
        passingMarks: 10.00,
        obtainedMarks: 20.00,
      ),
      SubjectMark(
        subjectId: '9',
        subjectName: 'ASSIGNMENT & CLASSROOM ACTIVITY',
        maximumMarks: 25.00,
        passingMarks: 10.00,
        obtainedMarks: 5.00,
      ),
    ];

    // Filter subjects if specific subject is selected
    if (selectedSubject.value?.id != '0' &&
        selectedSubject.value?.name != 'All Subjects') {
      return allSubjects
          .where((subject) =>
              subject.subjectName == selectedSubject.value?.name ||
              subject.subjectId == selectedSubject.value?.id)
          .toList();
    }

    return allSubjects;
  }

  /// Handle year filter change
  void onYearChanged(FilterOption? year) {
    if (year != null && selectedYear.value?.id != year.id) {
      selectedYear.value = year;
      loadMarksheet();
    }
  }

  /// Handle task filter change
  void onTaskChanged(FilterOption? task) {
    if (task != null && selectedTask.value?.id != task.id) {
      selectedTask.value = task;
      loadMarksheet();
    }
  }

  /// Handle subject filter change
  void onSubjectChanged(FilterOption? subject) {
    if (subject != null && selectedSubject.value?.id != subject.id) {
      selectedSubject.value = subject;
      loadMarksheet();
    }
  }

  /// Refresh marksheet data
  Future<void> refreshMarksheet() async {
    await loadMarksheet();
  }

  /// Toggle filter section expansion
  void toggleFilter() {
    isFilterExpanded.value = !isFilterExpanded.value;
  }

  /// Generate PDF from marksheet
  Future<void> generatePdf() async {
    if (marksheet.value == null) {
      Get.snackbar(
        'Error',
        'No marksheet data available to generate PDF',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isGeneratingPdf.value = true;

      final pdf = pw.Document();
      final data = marksheet.value!;

      // Add page to PDF
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (context) => _buildPdfContent(data),
        ),
      );

      // Save and share PDF
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename:
            'Marksheet_${data.studentInfo.name.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );

      Get.snackbar(
        'Success',
        'PDF generated successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to generate PDF: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isGeneratingPdf.value = false;
    }
  }

  /// Build PDF content
  pw.Widget _buildPdfContent(MarksheetModel data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Header
        _buildPdfHeader(data),
        pw.SizedBox(height: 20),

        // Student Info
        _buildPdfStudentInfo(data.studentInfo),
        pw.SizedBox(height: 20),

        // Marks Table
        _buildPdfMarksTable(data.subjects),
        pw.SizedBox(height: 20),

        // Footer
        _buildPdfFooter(),
      ],
    );
  }

  /// Build PDF header
  pw.Widget _buildPdfHeader(MarksheetModel data) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 2),
      ),
      padding: const pw.EdgeInsets.all(16),
      child: pw.Column(
        children: [
          pw.Text(
            data.schoolName ?? 'BENCHMARK School of Leadership',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            data.schoolTagline ?? 'PLAY GROUP TO O\' MATRIC',
            style: const pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 12),
          pw.Text(
            data.taskName,
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            data.session,
            style: const pw.TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  /// Build PDF student info
  pw.Widget _buildPdfStudentInfo(StudentInfo info) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        _buildPdfTableRow('Student\'s Name:', info.name, 'Class:', info.grade),
        _buildPdfTableRow(
            'Father\'s Name:', info.fatherName, 'Roll #:', info.rollNumber),
        _buildPdfTableRow('Result:', info.result,
            'Max. Marks:', info.totalMarks.toStringAsFixed(0)),
        _buildPdfTableRow(
            'Remarks:',
            info.remarks,
            'Obt. Marks:',
            '${info.obtainedMarks.toStringAsFixed(0)} / ${info.totalMarks.toStringAsFixed(0)}'),
        _buildPdfTableRow(
            '', '', 'Percentage:', info.percentage, 'Grade:', info.remarksGrade),
      ],
    );
  }

  /// Build PDF table row
  pw.TableRow _buildPdfTableRow(String label1, String value1,
      [String? label2, String? value2, String? label3, String? value3]) {
    return pw.TableRow(
      children: [
        _buildPdfCell(label1, isBold: true),
        _buildPdfCell(value1),
        if (label2 != null) _buildPdfCell(label2, isBold: true),
        if (value2 != null) _buildPdfCell(value2),
        if (label3 != null) _buildPdfCell(label3, isBold: true),
        if (value3 != null) _buildPdfCell(value3),
      ],
    );
  }

  /// Build PDF cell
  pw.Widget _buildPdfCell(String text, {bool isBold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  /// Build PDF marks table
  pw.Widget _buildPdfMarksTable(List<SubjectMark> subjects) {
    return pw.Table(
      border: pw.TableBorder.all(),
      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FlexColumnWidth(2),
      },
      children: [
        // Header
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey300),
          children: [
            _buildPdfCell('SUBJECT', isBold: true),
            _buildPdfCell('MAXIMUM MARKS', isBold: true),
            _buildPdfCell('PASSING MARKS', isBold: true),
            _buildPdfCell('OBTAINED MARKS', isBold: true),
          ],
        ),
        // Subject rows
        ...subjects.map((subject) => pw.TableRow(
              children: [
                _buildPdfCell(subject.subjectName),
                _buildPdfCell(subject.maximumMarks.toStringAsFixed(2)),
                _buildPdfCell(subject.passingMarks.toStringAsFixed(2)),
                _buildPdfCell(subject.obtainedMarks.toStringAsFixed(2)),
              ],
            )),
      ],
    );
  }

  /// Build PDF footer
  pw.Widget _buildPdfFooter() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(height: 1, width: 150, color: PdfColors.black),
            pw.SizedBox(height: 4),
            pw.Text('SIGN: CLASS TEACHER',
                style: const pw.TextStyle(fontSize: 10)),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(height: 1, width: 150, color: PdfColors.black),
            pw.SizedBox(height: 4),
            pw.Text('SIGN: PRINCIPAL', style: const pw.TextStyle(fontSize: 10)),
          ],
        ),
      ],
    );
  }

  @override
  void onClose() {
    // Clean up resources
    super.onClose();
  }
}