import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_reports/save_excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class ReportDetailsScreen extends StatefulWidget {
  final List<Map<String, String>> reportData;

  ReportDetailsScreen({Key? key, required this.reportData}) : super(key: key);
  @override
  _ReportDetailsScreenState createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  static const platform = MethodChannel('com.example.my_reports/files');

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _headerScrollController = ScrollController();

  static const int itemsPerPage = 14;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Synchronize the scroll controllers for horizontal scrolling
    _horizontalScrollController.addListener(() {
      _headerScrollController
          .jumpTo(_horizontalScrollController.position.pixels);
    });
  }

  List<Map<String, String>> get currentPageData {
    int start = currentPage * itemsPerPage;
    int end = start + itemsPerPage;
    return widget.reportData.sublist(
        start, end > widget.reportData.length ? widget.reportData.length : end);
  }

  Future<void> _requestPermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      // Proceed with the download after permission is granted
      await _downloadAsPdf();
    } else {
      // Show a message that permission is required
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Storage permission is required to save PDF.")),
      );

      // Open app settings to manually enable the permission
      await openAppSettings();
      status = await Permission.manageExternalStorage.status;
      if (status.isGranted) {
        await _downloadAsPdf();
      } else {
        // Permission still not granted
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enable storage permissions from settings."),
          ),
        );
      }
    }
  }

  void _goToNextPage() {
    if ((currentPage + 1) * itemsPerPage < widget.reportData.length) {
      setState(() {
        currentPage++;
      });
    }
  }

  void _goToPreviousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  void _downloadAsExcel() {}

  Future<void> _downloadAsPdf() async {
    final pdf = pw.Document();

    final headers = widget.reportData[0].keys.take(12).toList();
    final data = widget.reportData
        .take(12)
        .map((row) => row.values.take(12).map((e) => e.toString()).toList())
        .toList();

    // Add a page
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape, // Set to landscape mode

        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Report Details',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                // headers: widget.reportData.isNotEmpty
                //     ? widget.reportData[0].keys.toList()
                //     : [],
                // data: widget.reportData
                //     .map((row) => row.values.map((e) => e.toString()).toList())
                //     .toList(),
                headers: headers,
                data: data,
                border: pw.TableBorder.all(width: 1.0, color: PdfColors.black),
              ),
            ],
          );
        },
      ),
    );

    try {
      // Get the PDF file in bytes
      final pdfBytes = await pdf.save();

      // Call platform channel to save the PDF to the Downloads folder
      final result = await platform
          .invokeMethod('saveToDownloads', {'pdfBytes': pdfBytes});

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("PDF saved in Downloads folder")),
      );
    } on PlatformException catch (e) {
      print("Failed to save PDF: '${e.message}'.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save PDF: ${e.message}")),
      );
    }
  }

  final List<Map<String, String>> reportData = [
    {
      "S.No": "1",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "2",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "3",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "23",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "24",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
    {
      "S.No": "25",
      "Zone Code": "1",
      "Zone Manager": "DEVESH GILL",
      "Circle Code": "101",
      "Circle Name": "Circle A",
      "Block Code": "1",
      "Block Name": "HATA A",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double cellWidth = 150.0;
    double cellHeight = 50.0; // Fixed height for table cells
    // Fixed width for table cells

    return Scaffold(
      appBar: AppBar(
        title: Text("Report Details"),
        backgroundColor: Colors.green,
      ),
      body: widget.reportData.isEmpty
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                      // This makes the image fill the available vertical space
                      child: Image.asset(
                    'assets/no_data.png',
                    fit: BoxFit.cover,
                  )),
                ],
              ))
          : Column(
              children: [
                Row(
                  // This Row is used to align the vertical scroll with the header
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _headerScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: widget.reportData.isNotEmpty
                              ? widget.reportData[0].keys.map((header) {
                                  return Container(
                                    width: cellWidth,
                                    height: cellHeight,
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 112, 163, 251),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Text(
                                      header,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }).toList()
                              : [],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: currentPageData.asMap().entries.map((entry) {
                          int index = entry.key;
                          var data = entry.value;
                          return Row(
                            children: data.entries.map((entry) {
                              return Container(
                                width: cellWidth,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  color: index % 2 == 0
                                      ? Colors.grey[200]
                                      : Colors.white,
                                ),
                                child: Text(
                                  entry.value,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: _goToPreviousPage,
                    ),
                    Text('Page ${currentPage + 1}'),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: _goToNextPage,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
