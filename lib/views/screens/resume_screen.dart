import 'dart:developer';

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
  List tmpData = [];
  List anotherData = [];
  int i = 0;

  @override
  void initState() {
    resumeController.resumeItems.value.length > 4
        ? resumeController.resumeItems.value.forEach((element) {
            i < 4 ? tmpData.add(element) : (anotherData.add(element));
            i++;
          })
        : (tmpData = resumeController.resumeItems.value);
    log("TmpData $tmpData");
    generateResume();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Resume"), centerTitle: true),
      body: PdfPreview(build: (format) => pdf.save()),
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
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.SizedBox(height: 10),
                            pw.Container(
                                height: 100,
                                width: 100,
                                decoration: pw.BoxDecoration(
                                  shape: pw.BoxShape.circle,
                                  image: pw.DecorationImage(
                                      image: pw.MemoryImage(resumeController
                                          .file!
                                          .readAsBytesSync())),
                                )),
                            pw.SizedBox(height: 15),
                            pw.Text(resumeController.name.value,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 20,
                                    color: PdfColors.white)),
                            pw.SizedBox(height: 10),
                            pw.Text(resumeController.role.value,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 16,
                                    color: PdfColors.white)),
                            pw.SizedBox(height: 15),
                            ...anotherData.map((element) {
                              return pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  children: [
                                    pw.SizedBox(height: 15),
                                    pw.Text(element['name'],
                                        style: pw.TextStyle(
                                            fontSize: 23,
                                            color: PdfColors.white,
                                            fontWeight: pw.FontWeight.bold,
                                            decoration:
                                                pw.TextDecoration.underline)),
                                    pw.SizedBox(height: 7),
                                    ...element['item']
                                        .map((e) => pw.Text("- $e",
                                            style: const pw.TextStyle(
                                              fontSize: 20,
                                              color: PdfColors.white,
                                            )))
                                        .toList()
                                  ]);
                            }).toList(),
                          ]))),
              pw.Expanded(
                flex: 2,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 20),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: tmpData.map((element) {
                      return pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 15),
                            pw.Text(element['name'],
                                style: pw.TextStyle(
                                    fontSize: 22,
                                    fontWeight: pw.FontWeight.bold,
                                    decoration: pw.TextDecoration.underline)),
                            pw.SizedBox(height: 7),
                            ...element['item']
                                .map((e) => pw.Text("- $e",
                                    style: const pw.TextStyle(fontSize: 18)))
                                .toList(),
                          ]);
                    }).toList(),
                  ),
                ),
              ),
            ]),
          );
        }));
  }
}
