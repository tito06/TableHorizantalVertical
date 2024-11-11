import 'package:flutter/material.dart';
import 'package:my_reports/report_detail.dart';
import 'package:my_reports/report_view_model.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final ReportViewModel _reportViewModel = ReportViewModel();

  bool showAdvancedFields = false;
  bool isLoading = false;
  bool isVillageLoading = true;

  TextEditingController fromDateController = TextEditingController();

  TextEditingController toDateController = TextEditingController();
  TextEditingController fromZoneController = TextEditingController();
  TextEditingController toZoneController = TextEditingController();

  TextEditingController fromblockController = TextEditingController();
  TextEditingController toZBlockController = TextEditingController();

  TextEditingController fromCircleController = TextEditingController();
  TextEditingController toCircleController = TextEditingController();

  //sample data
  List<String> reportFor = ['Indent entry', 'Plant entry', 'Seed Entry'];
  List<String> seasonYear = ['2024', '2025'];
  List<String> date = ['Today', 'To Date', 'Date Range'];
  List<String> identType = [
    'Autumn',
    'Spring',
    'After Wheat',
    'Monsoon',
    'Ratoon Retention'
  ];
  List<String> dropdownItem5 = ['Option 1', 'Option 2', 'Option 3'];
  List<String> dropdownItem6 = ['Option 1', 'Option 2', 'Option 3'];
  List<String> selfType = ['All', 'Self'];
  List<Map<String, String>> villageData = [];

  //List<Map<String, String>> toVillage = [];

  String selctedReportfor = "";
  String selctedSeasonYear = "";
  String selcteddate = "";
  String selctedindentType = "";
  String selctedSelfType = "";
  String selectedFromVillageCode = "";

  String selectedToVillageCode = "";

  String startDate = "";
  String enddate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchVillageName();
    selctedReportfor = reportFor[0];
    selctedSeasonYear = seasonYear[0];
    selcteddate = date[0];
    selctedindentType = identType[0];
    selctedSelfType = selfType[0];
  }

  Future<void> _fetchVillageName() async {
    Map<String, String> requestDataForVillage = {"mill_id": "203"};
    try {
      final items = await _reportViewModel.fetchVillages(requestDataForVillage);
      setState(() {
        villageData = items;
        selectedFromVillageCode =
            villageData.isNotEmpty ? villageData[0]['V_CODE']! : "-";
        selectedToVillageCode =
            villageData.isNotEmpty ? villageData[0]['V_CODE']! : "-";
        isVillageLoading = false;
      });
    } catch (e) {
      print("Error fetching village name: $e");
      setState(() {
        isVillageLoading = false;
      });
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
  }

  Future<String?> _fetchReportAndNavigate(
    String reportFor,
    String season,
    String fromDate,
    String toDate,
    String indentType,
    String villageCode,
    String toVillageCode,
    String zoneCode,
    String blockCode,
    String circleCode,
  ) async {
    setState(() {
      isLoading = true;
    });

    Map<String, String> requestData = {
      "report_for": reportFor,
      "session_year": season,
      "from_date": fromDate,
      "to_date": toDate,
      "indent_type": indentType,
      "village_code": villageCode,
      "plot_village_code": toVillageCode,
      "zone_code": zoneCode,
      "block_code": blockCode,
      "circle_code": circleCode,
    };

    try {
      final reportData = await _reportViewModel.fetchReportData(requestData);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportDetailsScreen(reportData: reportData),
        ),
      );
    } catch (e) {
      print("Error fetching report data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (isVillageLoading) // Show the loader while fetching village data
              Center(child: CircularProgressIndicator()),
            if (!isVillageLoading) ...[
              // First Row: Dropdowns 1 and 2
              Row(
                children: [
                  Expanded(
                      child: _buildDropdownField(
                          "Report for", reportFor, selctedReportfor,
                          (String? newValue) {
                    setState(() {
                      String value = newValue!;
                      selctedReportfor =
                          value.toLowerCase().replaceAll(' ', '_');
                    });
                  })),
                  SizedBox(width: 16),
                  Expanded(
                      child: _buildDropdownField(
                          "Season Year", seasonYear, selctedSeasonYear,
                          (String? newValue) {
                    setState(() {
                      selctedSeasonYear = newValue!;
                    });
                  })),
                ],
              ),
              SizedBox(height: 16),

              // Second Row: Dropdowns 3 and 4
              Row(
                children: [
                  Expanded(
                      child: _buildDropdownField("Date", date, selcteddate,
                          (String? newValue) {
                    setState(() {
                      selcteddate = newValue!;
                      if (selcteddate == "Today") {
                        final DateTime now = DateTime.now();
                        fromDateController.text =
                            "${now.day}-${now.month}-${now.year}";
                        toDateController.text =
                            "${now.day}-${now.month}-${now.year}";
                      }
                    });
                  })),
                  SizedBox(width: 16),
                  Expanded(
                      child: _buildDropdownField(
                          "Indent Type", identType, selctedindentType,
                          (String? newValue) {
                    setState(() {
                      selctedindentType = newValue!;
                    });
                  })),
                ],
              ),
              SizedBox(height: 16),

              if (selcteddate != 'Today')
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("From Date",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          TextField(
                            controller: fromDateController,
                            decoration: const InputDecoration(
                              labelText: "Select Date",
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true,
                            onTap: () =>
                                _selectDate(context, fromDateController),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("To Date",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          TextField(
                            controller: toDateController,
                            decoration: const InputDecoration(
                              labelText: "Select Date",
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true,
                            onTap: () => _selectDate(context, toDateController),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                      child: _buildDropdownField(
                          "From Village",
                          villageData
                              .map((village) =>
                                  "${village['V_CODE']} / ${village['V_NAME']}")
                              .toList(),
                          selectedFromVillageCode, (String? newValue) {
                    setState(() {
                      selectedFromVillageCode =
                          newValue != null ? newValue.split(' / ')[0] : '';
                    });
                  })),
                  SizedBox(width: 16),
                  Expanded(
                      child: _buildDropdownField(
                          "To Village",
                          villageData
                              .map((village) =>
                                  "${village['V_CODE']} / ${village['V_NAME']}")
                              .toList(),
                          selectedToVillageCode, (String? newValue) {
                    setState(() {
                      selectedToVillageCode =
                          newValue != null ? newValue.split(' / ')[0] : '';
                    });
                  })),
                ],
              ),
              // Advanced Search checkbox
              CheckboxListTile(
                title: Text("Advanced Search"),
                value: showAdvancedFields,
                onChanged: (value) {
                  setState(() {
                    showAdvancedFields = value ?? false;
                  });
                },
              ),

              // Button(s) based on checkbox state

              // Advanced Fields (shown only if checkbox is checked)
              if (showAdvancedFields) ...[
                _buildDropdownField("Self Type", selfType, selctedSelfType,
                    (String? newValue) {
                  setState(() {
                    selctedSelfType = newValue!;
                  });
                }),
                SizedBox(height: 16),
                Row(children: [
                  Expanded(
                      child: _buildTextField(
                          "From Zone Code", fromZoneController)),
                  SizedBox(width: 16),
                  Expanded(
                      child: _buildTextField("To Zone Code", toZoneController))
                ]),
                SizedBox(height: 16),
                Row(children: [
                  Expanded(
                      child: _buildTextField(
                          "From Block Code", fromblockController)),
                  SizedBox(width: 16),
                  Expanded(
                      child:
                          _buildTextField("To Block Code", toZBlockController))
                ]),
                SizedBox(height: 16),
                Row(children: [
                  Expanded(
                      child: _buildTextField(
                          "From Circle Code", fromCircleController)),
                  SizedBox(width: 16),
                  Expanded(
                      child:
                          _buildTextField("To Circle Code", toCircleController))
                ])
              ],
              SizedBox(height: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                await _fetchReportAndNavigate(
                                  selctedReportfor,
                                  selctedSeasonYear,
                                  fromDateController.text,
                                  toDateController.text,
                                  selctedindentType,
                                  selectedFromVillageCode,
                                  selectedToVillageCode,
                                  fromZoneController.text,
                                  fromblockController.text,
                                  fromCircleController.text,
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 5, 108, 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Set your desired border radius
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.green,
                              )
                            : const Text(
                                "Get summary",
                                style: TextStyle(color: Colors.white),
                              ),
                      )),
                  if (showAdvancedFields) ...[
                    SizedBox(height: 16),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Secondary action for advanced search
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 5, 108, 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: const Text(
                            "Get Villagewise summary",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                ],
              ),
            ],
          ]),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items,
      String selectedValue, ValueChanged<String?> onChanged) {
    if (!items.contains(selectedValue)) {
      selectedValue =
          items.isNotEmpty ? items[0] : ""; // Set to first item or default
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: null,
          hint: Text("Select Option"),
          isExpanded: true,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
