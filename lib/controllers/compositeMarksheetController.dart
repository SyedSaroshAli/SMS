// ignore_for_file: file_names, avoid_print, unnecessary_overrides

import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:school_management_system/models/compositeMarksheetModel.dart';


class CompositeMarksheetController extends GetxController {
  // Observable variables
  final isLoading = false.obs;
  final isFilterExpanded = false.obs;
  final errorMessage = ''.obs;
  final yearlyMarks = <CompositeMarksheetModel>[].obs;
  final selectedMarksheet = Rx<CompositeMarksheetModel?>(null);
  final marksheetData = Rxn<CompositeMarksheetModel>();
  final isGeneratingPdf = false.obs;

  // Filters
  final selectedYear = Rx<String?>(null);
  final availableYears = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadYearlyData();
  }

  /// Load yearly composite marksheet data
  Future<void> loadYearlyData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      
      // final response = await apiService.getCompositeMarksheets();
      // yearlyMarks.value = response.map((json) => CompositeMarksheetModel.fromJson(json)).toList();

      // Using dummy data for now
      yearlyMarks.value = _getDummyData();

      // Extract available years
      availableYears.value = yearlyMarks
          .map((m) => m.academicYear)
          .toSet()
          .toList()
        ..sort((a, b) => b.compareTo(a)); // Latest first

      if (availableYears.isNotEmpty) {
        selectedYear.value = availableYears.first;
        _setCurrentMarksheetForSelectedYear();
      }
    } catch (e) {
      errorMessage.value = 'Failed to load marksheets: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Select a marksheet to view details
  void selectMarksheet(CompositeMarksheetModel marksheet) {
    selectedMarksheet.value = marksheet;
    marksheetData.value = marksheet;
  }

  /// Filter by year
  void filterByYear(String year) {
    selectedYear.value = year;
    _setCurrentMarksheetForSelectedYear();
  }

  /// Get filtered marksheets
  List<CompositeMarksheetModel> get filteredMarksheets {
    if (selectedYear.value == null) return yearlyMarks;
    return yearlyMarks
        .where((m) => m.academicYear == selectedYear.value)
        .toList();
  }

  void _setCurrentMarksheetForSelectedYear() {
    final year = selectedYear.value;
    if (year == null) return;

    final byYear = yearlyMarks.where((m) => m.academicYear == year).toList();
    if (byYear.isEmpty) {
      selectedMarksheet.value = null;
      marksheetData.value = null;
      return;
    }

    // If multiple exist for a year, prefer most recent.
    byYear.sort((a, b) {
      final aTs = a.createdAt?.millisecondsSinceEpoch ?? 0;
      final bTs = b.createdAt?.millisecondsSinceEpoch ?? 0;
      return bTs.compareTo(aTs);
    });

    selectMarksheet(byYear.first);
  }
  void toggleFilter() {
    isFilterExpanded.value = !isFilterExpanded.value;
  }

  /// Generate PDF for selected marksheet
  Future<void> generatePdf() async {
    if (selectedMarksheet.value == null) {
      Get.snackbar(
        'Error',
        'No marksheet selected',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isGeneratingPdf.value = true;

      final pdf = pw.Document();
      final marksheet = selectedMarksheet.value!;

      // Load student photo if available
      pw.ImageProvider? studentPhoto;
      if (marksheet.studentInfo.photoUrl != null &&
          marksheet.studentInfo.photoUrl!.isNotEmpty) {
        try {
          studentPhoto = await networkImage(marksheet.studentInfo.photoUrl!);
        } catch (e) {
          print('Failed to load photo: $e');
        }
      }

      // Add page to PDF
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(24),
          build: (context) => [
            _buildPdfHeader(marksheet, studentPhoto),
            pw.SizedBox(height: 16),
            _buildPdfStudentInfo(marksheet.studentInfo),
            pw.SizedBox(height: 16),
            _buildPdfTable(marksheet),
            pw.SizedBox(height: 30),
            _buildPdfFooter(),
          ],
        ),
      );

      // Save and share PDF
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename:
            'Transcript_${marksheet.studentInfo.studentName.replaceAll(' ', '_')}_${marksheet.academicYear}.pdf',
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

  /// Build PDF header with photo
  pw.Widget _buildPdfHeader(
      CompositeMarksheetModel marksheet, pw.ImageProvider? photo) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 2),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  'TRANSCRIPT',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'FOR THE ACADEMIC YEAR ${marksheet.academicYear}',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (photo != null)
            pw.Container(
              width: 80,
              height: 100,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(width: 2),
              ),
              child: pw.Image(photo, fit: pw.BoxFit.cover),
            )
          else
            pw.Container(
              width: 80,
              height: 100,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(width: 2),
                color: PdfColors.grey300,
              ),
            ),
        ],
      ),
    );
  }

  /// Build PDF student info section
  pw.Widget _buildPdfStudentInfo(StudentInfo info) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            _buildPdfInfoCell('Student\'s Name', true),
            _buildPdfInfoCell(info.studentName, false),
            _buildPdfInfoCell('Std. Id', true),
            _buildPdfInfoCell(info.studentId, false),
            _buildPdfInfoCell('Class', true),
            _buildPdfInfoCell(info.className, false),
          ],
        ),
        pw.TableRow(
          children: [
            _buildPdfInfoCell('Father\'s Name', true),
            _buildPdfInfoCell(info.fatherName, false),
            _buildPdfInfoCell('', true),
            _buildPdfInfoCell(info.rollNo, false),
            _buildPdfInfoCell('Roll #', true),
            _buildPdfInfoCell(info.rollNo, false),
          ],
        ),
        pw.TableRow(
          children: [
            _buildPdfInfoCell('Result', true),
            _buildPdfInfoCell(info.result, false),
            _buildPdfInfoCell('Max. Marks', true),
            _buildPdfInfoCell(info.totalMaxMarks.toStringAsFixed(0), false),
            _buildPdfInfoCell('Percentage', true),
            _buildPdfInfoCell('${info.percentage.toStringAsFixed(2)} %', false),
          ],
        ),
        pw.TableRow(
          children: [
            _buildPdfInfoCell('Position', true),
            _buildPdfInfoCell(info.position, false),
            _buildPdfInfoCell('Obt. Marks', true),
            _buildPdfInfoCell(info.totalObtainedMarks.toStringAsFixed(0), false),
            _buildPdfInfoCell('Grade', true),
            _buildPdfInfoCell(info.grade, false),
          ],
        ),
      ],
    );
  }

  /// Build PDF info cell
  pw.Widget _buildPdfInfoCell(String text, bool isBold) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  /// Build PDF table with all assessments
  pw.Widget _buildPdfTable(CompositeMarksheetModel marksheet) {
    List<pw.TableRow> rows = [];

    // Header row
    rows.add(
      pw.TableRow(
        decoration: const pw.BoxDecoration(color: PdfColors.grey400),
        children: [
          _buildPdfTableHeader('Learning Area'),
          _buildPdfTableHeader('Subject'),
          _buildPdfTableHeader('Assessment Title'),
          _buildPdfTableHeader('Max\nMarks'),
          _buildPdfTableHeader('Passing\nMarks'),
          _buildPdfTableHeader('Obt\nMarks'),
          _buildPdfTableHeader('Agg.\nMarks'),
        ],
      ),
    );

    // Data rows
    for (var subjectAssessment in marksheet.subjectAssessments) {
      final assessments = subjectAssessment.assessments;

      for (int i = 0; i < assessments.length; i++) {
        final assessment = assessments[i];
        final isFirst = i == 0;
        final isLast = i == assessments.length - 1;

        rows.add(
          pw.TableRow(
            children: [
              // Learning Area - show only once per subject
              isFirst
                  ? pw.Container(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(
                        subjectAssessment.learningArea,
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                    )
                  : pw.Container(),
              // Subject - show only once per subject
              isFirst
                  ? pw.Container(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(
                        subjectAssessment.subject,
                        style: pw.TextStyle(
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    )
                  : pw.Container(),
              // Assessment details
              _buildPdfTableCell(assessment.assessmentTitle),
              _buildPdfTableCell(assessment.maxMarks.toStringAsFixed(0),
                  center: true),
              _buildPdfTableCell(assessment.passingMarks.toStringAsFixed(0),
                  center: true),
              _buildPdfTableCell(assessment.obtainedMarks.toStringAsFixed(0),
                  center: true),
              // Aggregate - show only on last row
              isLast
                  ? pw.Container(
                      padding: const pw.EdgeInsets.all(6),
                      color: PdfColors.blue50,
                      child: pw.Text(
                        subjectAssessment.aggregateObtainedMarks
                            .toStringAsFixed(0),
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    )
                  : pw.Container(),
            ],
          ),
        );
      }
    }

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey600),
      columnWidths: {
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(2.5),
        3: const pw.FlexColumnWidth(1),
        4: const pw.FlexColumnWidth(1),
        5: const pw.FlexColumnWidth(1),
        6: const pw.FlexColumnWidth(1),
      },
      children: rows,
    );
  }

  /// Build PDF table header
  pw.Widget _buildPdfTableHeader(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  /// Build PDF table cell
  pw.Widget _buildPdfTableCell(String text, {bool center = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        textAlign: center ? pw.TextAlign.center : pw.TextAlign.left,
        style: const pw.TextStyle(fontSize: 9),
      ),
    );
  }

  /// Build PDF footer with signature space
  pw.Widget _buildPdfFooter() {
    return pw.Column(
      children: [
        pw.SizedBox(height: 40),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            _buildSignature('Class Teacher'),
            _buildSignature('Principal'),
            _buildSignature('Parent/Guardian'),
          ],
        ),
      ],
    );
  }

  /// Build signature line
  pw.Widget _buildSignature(String label) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(width: 120, height: 1, color: PdfColors.black),
        pw.SizedBox(height: 4),
        pw.Text(label, style: const pw.TextStyle(fontSize: 9)),
      ],
    );
  }

  /// Get dummy data matching the image structure
  List<CompositeMarksheetModel> _getDummyData() {
    return [
      CompositeMarksheetModel(
        academicYear: '2025-2026',
        studentInfo: StudentInfo(
          studentId: '506',
          studentName: 'ANAIZA FATIMA',
          fatherName: 'MD SUHAIL KHAN',
          rollNo: '29',
          className: 'MONT JUNIOR',
          position: '',
          result: 'TRY AGAIN',
          grade: 'B',
          totalMaxMarks: 1950,
          totalObtainedMarks: 1300,
          percentage: 66.67,
        ),
        subjectAssessments: [
          SubjectAssessment(
            learningArea: 'RELIGION',
            subject: 'ISLAMIAT',
            assessments: [
              Assessment(
                assessmentId: '1',
                assessmentTitle: 'Mid Term',
                maxMarks: 100,
                passingMarks: 40,
                obtainedMarks: 66,
              ),
              Assessment(
                assessmentId: '2',
                assessmentTitle: 'Annual Term',
                maxMarks: 100,
                passingMarks: 40,
                obtainedMarks: 55,
              ),
              Assessment(
                assessmentId: '3',
                assessmentTitle: 'Preliminary Test (Fall)',
                maxMarks: 25,
                passingMarks: 10,
                obtainedMarks: 25,
              ),
              Assessment(
                assessmentId: '4',
                assessmentTitle: 'Preliminary Test (Spring)',
                maxMarks: 25,
                passingMarks: 10,
                obtainedMarks: 7,
              ),
            ],
            aggregateMaxMarks: 250,
            aggregateObtainedMarks: 183,
          ),
          SubjectAssessment(
            learningArea: 'NATIVE LANGUAGE',
            subject: 'URDU',
            assessments: [
              Assessment(
                assessmentId: '5',
                assessmentTitle: 'Mid Term',
                maxMarks: 100,
                passingMarks: 40,
                obtainedMarks: 78,
              ),
              Assessment(
                assessmentId: '6',
                assessmentTitle: 'Annual Term',
                maxMarks: 100,
                passingMarks: 40,
                obtainedMarks: 55,
              ),
              Assessment(
                assessmentId: '7',
                assessmentTitle: 'Preliminary Test (Fall)',
                maxMarks: 25,
                passingMarks: 10,
                obtainedMarks: 22,
              ),
              Assessment(
                assessmentId: '8',
                assessmentTitle: 'Preliminary Test (Spring)',
                maxMarks: 25,
                passingMarks: 10,
                obtainedMarks: 5,
              ),
            ],
            aggregateMaxMarks: 250,
            aggregateObtainedMarks: 160,
          ),
          // Add more subjects as needed...
        ],
      ),
    ];
  }

  @override
  void onClose() {
    super.onClose();
  }
}