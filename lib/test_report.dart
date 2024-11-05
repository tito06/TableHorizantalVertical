import 'package:flutter/material.dart';

class TestReport extends StatefulWidget {
  const TestReport({super.key});

  @override
  State<TestReport> createState() => _TestReportState();
}

class _TestReportState extends State<TestReport> {
  final List<Map<String, String>> data = [
    {
      "Name": "John Doe",
      "Age": "30",
      "City": "New York",
      "Occupation": "Engineer",
      "Country": "USA",
      "Salary": "\$80,000"
    },
    {
      "Name": "Jane Smith",
      "Age": "25",
      "City": "London",
      "Occupation": "Designer",
      "Country": "UK",
      "Salary": "\$70,000"
    },
    {
      "Name": "Sam Wilson",
      "Age": "28",
      "City": "Paris",
      "Occupation": "Artist",
      "Country": "France",
      "Salary": "\$50,000"
    },
    {
      "Name": "Mike Johnson",
      "Age": "35",
      "City": "Berlin",
      "Occupation": "Architect",
      "Country": "Germany",
      "Salary": "\$90,000"
    },
    {
      "Name": "Lisa Brown",
      "Age": "32",
      "City": "Tokyo",
      "Occupation": "Scientist",
      "Country": "Japan",
      "Salary": "\$85,000"
    },
    {
      "Name": "Chris Lee",
      "Age": "29",
      "City": "Toronto",
      "Occupation": "Developer",
      "Country": "Canada",
      "Salary": "\$75,000"
    },
    {
      "Name": "Emma Davis",
      "Age": "22",
      "City": "Sydney",
      "Occupation": "Marketing",
      "Country": "Australia",
      "Salary": "\$65,000"
    },
    {
      "Name": "Oliver Wilson",
      "Age": "27",
      "City": "Madrid",
      "Occupation": "Manager",
      "Country": "Spain",
      "Salary": "\$80,000"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Age')),
            DataColumn(label: Text('City')),
            DataColumn(label: Text('Occupation')),
            DataColumn(label: Text('Country')),
            DataColumn(label: Text('Salary')),
          ],
          rows: data.map((row) {
            return DataRow(cells: [
              DataCell(Text(row["Name"]!)),
              DataCell(Text(row["Age"]!)),
              DataCell(Text(row["City"]!)),
              DataCell(Text(row["Occupation"]!)),
              DataCell(Text(row["Country"]!)),
              DataCell(Text(row["Salary"]!)),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
