import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReportDetailsScreen extends StatefulWidget {
  @override
  _ReportDetailsScreenState createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _headerScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Synchronize the scroll controllers for horizontal scrolling
    _horizontalScrollController.addListener(() {
      _headerScrollController
          .jumpTo(_horizontalScrollController.position.pixels);
    });
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
      body: Column(
        children: [
          Row(
            // This Row is used to align the vertical scroll with the header
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _headerScrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: reportData[0].keys.map((header) {
                      return Container(
                        width: cellWidth,
                        height: cellHeight,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 112, 163, 251),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          header,
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
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                controller: _horizontalScrollController,
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: reportData.asMap().entries.map((entry) {
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
          ),
        ],
      ),
    );
  }
}
