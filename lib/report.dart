import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReportTable extends StatefulWidget {
  final List<String> items;
  final List<Map<String, String>> reportData;

  ReportTable({required this.items, required this.reportData});

  @override
  _ReportTableState createState() => _ReportTableState();
}

class _ReportTableState extends State<ReportTable> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _headerScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // Synchronize the scroll controllers for horizontal scrolling
    _horizontalScrollController.addListener(() {
      _headerScrollController
          .jumpTo(_horizontalScrollController.position.pixels);
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _horizontalScrollController.dispose();
    _headerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double cellWidth = 150.0; // Fixed width for table cells

    return Padding(
      padding: EdgeInsets.all(8.0), // Padding around the table
      child: Column(
        children: [
          // Header Row with fixed "Items" and scrollable month headers
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fixed "Items" Header Column
              Container(
                width: cellWidth,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  'Items',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              // Scrollable Month Headers
              Expanded(
                child: SingleChildScrollView(
                  controller: _headerScrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.reportData[0].keys.map((month) {
                      return Container(
                        width: cellWidth,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.1),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          month,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          // Data Rows with vertical scrolling and synchronized horizontal scrolling for months
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fixed "Items" Column for each data row
                  Column(
                    children: widget.items.asMap().entries.map((entry) {
                      int index = entry.key;
                      return Container(
                        width: cellWidth,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color:
                              index % 2 == 0 ? Colors.grey[200] : Colors.white,
                        ),
                        child: Text(
                          entry.value,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),
                  // Scrollable Data Columns
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children:
                            widget.reportData.asMap().entries.map((entry) {
                          int index = entry.key;
                          var data = entry.value;
                          return Row(
                            children: data.entries.map((entry) {
                              return Container(
                                width: cellWidth,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
