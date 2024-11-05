import 'package:flutter/material.dart';
import 'package:my_reports/inputField.dart';
import 'package:my_reports/report.dart';

class Myreport extends StatefulWidget {
  const Myreport({super.key});

  @override
  State<Myreport> createState() => _MyreportState();
}

class _MyreportState extends State<Myreport> {
  final List<String> names = ['Alice', 'Bob', 'Charlie', 'David'];
  final List<String> years = ['2022', '2023', '2024'];
  final List<String> types = ['Type 1', 'Type 2', 'Type 3'];
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10'
  ];
  final List<Map<String, String>> reportData = [
    {
      'January': '100',
      'February': '150',
      'March': '120',
      'April': '550',
      'May': '200',
      'June': '542',
      'July': '200',
      'August': '300'
    },
    {
      'January': '200',
      'February': '250',
      'March': '220',
      'April': '550',
      'May': '200',
      'June': '542',
      'July': '200',
      'August': '300'
    },
    {
      'January': '300',
      'February': '350',
      'March': '320',
      'April': '550',
      'May': '200',
      'June': '542',
      'July': '200',
      'August': '300'
    },
    {
      'January': '400',
      'February': '450',
      'March': '420',
      'April': '550',
      'May': '200',
      'June': '542',
      'July': '200',
      'August': '300'
    },
    {
      'January': '500',
      'February': '550',
      'March': '520',
      'April': '550',
      'May': '200',
      'June': '542',
      'July': '200',
      'August': '300'
    },
    {
      'January': '300',
      'February': '350',
      'March': '320',
      'April': '550',
      'May': '200',
      'June': '542',
      'July': '200',
      'August': '300'
    },
    {
      'January': '300',
      'February': '350',
      'March': '320',
      'April': '550',
      'May': '200',
      'June': '542',
      'July': '200',
      'August': '300'
    },
    {
      'January': '300',
      'February': '350',
      'March': '320',
      'April': '550',
      'May': '200',
      'June': '542',
      'July': '200',
      'August': '300'
    },
    {
      'January': '300',
      'February': '350',
      'March': '320',
      'April': '550',
      'May': '200',
      'June': '542',
      'July': '200',
      'August': '300'
    },
    {
      'January': '300',
      'February': '350',
      'March': '320',
      'April': '550',
      'May': '200',
      'June': '542',
      'July': '200',
      'August': '300'
    },
  ];

  String? selectedName;
  String? selectedYear;
  String? selectedTypeFrom;
  String? selectedTypeTo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: Column(
        children: [
          // Input Fields
          InputFields(
            names: names,
            years: years,
            types: types,
            selectedName: selectedName,
            selectedYear: selectedYear,
            selectedTypeFrom: selectedTypeFrom,
            selectedTypeTo: selectedTypeTo,
            onNameChanged: (value) {
              setState(() {
                selectedName = value;
              });
            },
            onYearChanged: (value) {
              setState(() {
                selectedYear = value;
              });
            },
            onTypeFromChanged: (value) {
              setState(() {
                selectedTypeFrom = value;
              });
            },
            onTypeToChanged: (value) {
              setState(() {
                selectedTypeTo = value;
              });
            },
          ),
          SizedBox(height: 16),
          // Report Table
          Expanded(
            child: ReportTable(
              items: items,
              reportData: reportData,
            ),
          ),
        ],
      ),
    );
  }
}
