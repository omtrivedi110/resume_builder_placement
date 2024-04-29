import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:resume_builder_placement/controllers/resume_controller.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  pw.Document pdf = pw.Document();
  ResumeController resumeController = Get.put(ResumeController());

  @override
  void initState() {
    generateResume();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Resume"),
        centerTitle: true,
      ),
      body: PdfPreview(
        build: (format) => pdf.save(),
      ),
    );
  }

  generateResume() async {
    pdf.addPage(pw.Page(
        margin: pw.EdgeInsets.zero,
        build: (pw.Context context) {
          return pw.Container(
            height: double.infinity,
            width: double.infinity,
            child: pw.Row(children: [
              pw.Expanded(
                  flex: 1,
                  child: pw.Container(
                      height: double.infinity,
                      color: PdfColors.blue,
                      child: pw.Column(children: [
                        pw.Text(resumeController.name.value,
                            style: pw.TextStyle(
                                fontSize: 20, color: PdfColors.white)),
                        pw.Text(resumeController.role.value,
                            style: pw.TextStyle(
                                fontSize: 16, color: PdfColors.white)),
                      ]))),
              pw.Expanded(
                  flex: 2,
                  child: pw.Column(
                    children: resumeController.resumeItems.value.map((element) {
                      return pw.Column(children: [
                        pw.Text(element['name'],
                            style: pw.TextStyle(fontSize: 18)),
                        ...element['item'].map((e) => pw.Text("* $e")).toList(),
                      ]);
                    }).toList(),
                  )),
            ]),
          );
        }));
  }
}
