import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_reports/myreport.dart';
import 'package:my_reports/report.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bar chart container at the top
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fixed Y-axis (Years) on the left
              Container(
                width: 60, // Adjust width as needed for the Y-axis labels
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Column(
                  children: List.generate(5, (index) {
                    int year = 2020 + index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        year.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  }),
                ),
              ),
              // Scrollable Bar Chart on the right
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 225, // Adjust height as needed
                    width: 600, // Set width to fit more bars; adjust as needed
                    padding: EdgeInsets.all(16),
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceEvenly,
                        maxY: 2024, // Set max year as per your requirement
                        minY: 2020, // Set min year as per your requirement
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                // Display name on the X-axis
                                final names = [
                                  'Prasant',
                                  'Rahul',
                                  'Mina',
                                  'Kanisk',
                                  'Tom',
                                  'Harry'
                                ];
                                if (value.toInt() < names.length) {
                                  return Text(names[value.toInt()]);
                                }
                                return Text('');
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(
                                toY: 2021,
                                color: const Color.fromARGB(255, 51, 106, 53)),
                          ]),
                          BarChartGroupData(x: 1, barRods: [
                            BarChartRodData(
                                toY: 2022,
                                color: const Color.fromARGB(255, 51, 106, 53)),
                          ]),
                          BarChartGroupData(x: 2, barRods: [
                            BarChartRodData(
                                toY: 2023,
                                color: const Color.fromARGB(255, 51, 106, 53)),
                          ]),
                          BarChartGroupData(x: 3, barRods: [
                            BarChartRodData(
                                toY: 2024,
                                color: const Color.fromARGB(255, 51, 106, 53)),
                          ]),
                          BarChartGroupData(x: 4, barRods: [
                            BarChartRodData(
                                toY: 2022,
                                color: const Color.fromARGB(255, 51, 106, 53)),
                          ]),
                          BarChartGroupData(x: 5, barRods: [
                            BarChartRodData(
                                toY: 2021,
                                color: const Color.fromARGB(255, 51, 106, 53)),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Buttons and additional information
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Myreport()),
                      );
                    },
                    child: Text('My reports '),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Button action
                    },
                    child: Text('Button 2'),
                  ),
                  // Additional info below buttons
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Additional information goes here.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
