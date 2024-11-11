import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';

const platform = MethodChannel('com.example.app/save_to_storage');

Future<void> saveExcelToDownloads(List<Map<String, String>> reportData) async {
  // Create a new Excel document
  var excel = Excel.createExcel();
  Sheet sheet = excel['Sheet1'];

  // Create the header row
  List<String> headers = reportData[0].keys.toList();
  sheet.appendRow(headers.cast<CellValue?>());

  // Add the data rows
  for (var row in reportData) {
    sheet.appendRow(row.values.cast<CellValue?>().toList());
  }

  // Save the Excel file to a byte list
  var excelBytes = await excel.save()!;

  // Convert the byte data to a file and save it in the Downloads folder
  String fileName = "report_${DateTime.now().millisecondsSinceEpoch}.xlsx";
  await saveFileToDownloads(fileName, excelBytes);
}

Future<void> saveFileToDownloads(String fileName, List<int> fileBytes) async {
  try {
    await platform.invokeMethod('saveFileToMediaStore', {
      'fileName': fileName,
      'fileBytes': fileBytes,
    });
  } on PlatformException catch (e) {
    print("Failed to save file: '${e.message}'.");
  }
}
