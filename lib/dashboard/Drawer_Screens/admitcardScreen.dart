

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:school_management_system/controllers/admit_card_controller.dart';
import 'package:school_management_system/models/admitcardModel.dart';


class AdmitCardScreen extends StatelessWidget {
  const AdmitCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdmitCardController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admit Card"),
        actions: [
          Obx(() => controller.admitCard.value == null
              ? const SizedBox()
              : IconButton(
                  icon: controller.isGeneratingPdf.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      : const Icon(Icons.picture_as_pdf),
                  onPressed: controller.isGeneratingPdf.value
                      ? null
                      : () => _generatePdf(controller),
                )),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.admitCard.value;
        if (data == null) {
          return const Center(child: Text("No Data"));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: _buildAdmitCardUI(data),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAdmitCardUI(AdmitCardModel data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        children: [
          _buildHeader(data),
          _buildTable(data),
          const SizedBox(height: 40),
          _buildSignatures(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader(AdmitCardModel data) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black),
                ),
                child: data.logoUrl != null
                    ? ClipOval(child: Image.network(data.logoUrl!, fit: BoxFit.cover))
                    : const Icon(Icons.school, size: 50),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      data.schoolName,
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data.schoolTagline,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                      color: Colors.black,
                      child: Text(
                        data.schoolSubTagline,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "ADMIT CARD",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            data.examTitle,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(AdmitCardModel data) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(4),
        2: FlexColumnWidth(2),
      },
      children: [
        TableRow(children: [
          _cell("Student's Name"),
          _cell(data.studentName),
          _photoCell(data.photoUrl),
        ]),
        TableRow(children: [
          _cell("Father's Name"),
          _cell(data.fatherName),
          const SizedBox(),
        ]),
        TableRow(children: [
          _cell("Class"),
          _cell("${data.className}     Section: ${data.section}"),
          const SizedBox(),
        ]),
        TableRow(children: [
          _cell("Admission No."),
          _cell("${data.admissionNo}   G.R No: ${data.grNo}   Seat No: ${data.seatNo}"),
          const SizedBox(),
        ]),
      ],
    );
  }

  Widget _cell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _photoCell(String? url) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(6),
      child: url != null
          ? Image.network(url, fit: BoxFit.cover)
          : const Icon(Icons.person, size: 60),
    );
  }

  Widget _buildSignatures() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("Signature of Controller"),
          Text("Signature of Class Teacher"),
        ],
      ),
    );
  }

  Future<void> _generatePdf(AdmitCardController controller) async {
    controller.isGeneratingPdf.value = true;
    final data = controller.admitCard.value!;
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (_) => pw.Center(
          child: pw.Text("PDF Design Same As UI — Build similarly using pw widgets"),
        ),
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: "AdmitCard.pdf",
    );

    controller.isGeneratingPdf.value = false;
  }
}
