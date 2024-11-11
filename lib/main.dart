import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_reports/dashboard.dart';
import 'package:my_reports/inputField.dart';
import 'package:my_reports/myreport.dart';
import 'package:my_reports/report.dart';
import 'package:my_reports/report_detail.dart';
import 'package:my_reports/reports.dart';
import 'package:my_reports/test_report.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DashboardScreen(),
    );
  }
}
