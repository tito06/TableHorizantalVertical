import 'package:flutter/material.dart';
import 'package:my_reports/add_partition.dart';
import 'package:my_reports/final_form.dart';

class PartitionScreen extends StatefulWidget {
  // final List<Map<String, dynamic>>? areaData;
  final Map<String, dynamic>? surveyData;

  PartitionScreen({this.surveyData});

  @override
  State<PartitionScreen> createState() => _PartitionScreenState();
}

class _PartitionScreenState extends State<PartitionScreen> {
  List<String> partion = ['No partition', '1', '2', '3'];
  String? selectedPartion;
  final TextEditingController _inputController1 = TextEditingController();
  List<Map<String, dynamic>>? areaData;

  @override
  void initState() {
    super.initState();
    print(widget.surveyData);
    _inputController1.text = "Dummy Input 1";

    selectedPartion = partion[0];
  }

  @override
  Widget build(BuildContext context) {
    // final areaData = widget.areaData;
    Map<String, dynamic> surveyData = widget.surveyData ?? {};

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "New Survey(2)",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/bgm.png'), // Add your background image path
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.85), // Make it light and subtle
                  BlendMode.dstATop,
                ),
              ),
            ),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<String>(
                            value: selectedPartion,
                            items: partion.map((partion) {
                              return DropdownMenuItem<String>(
                                value: partion,
                                child: Text(partion),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPartion = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Partion",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (selectedPartion != "No partition")
                            Row(children: [
                              Expanded(
                                child: TextField(
                                  controller: _inputController1,
                                  decoration: InputDecoration(
                                    labelText: "Input 1",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            const Color.fromARGB(
                                                255, 146, 214, 148))),
                                onPressed: () async {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AreaScreen(
                                                balanceArea: 50,
                                              )));

                                  if (result != null) {
                                    setState(() {
                                      areaData = result;
                                    });
                                  }
                                },
                                child: Text(
                                  "Add Partition",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ]),
                          SizedBox(height: 20),
                          if (areaData != null && areaData != " ") ...[
                            const Text(
                              "Partition:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: areaData!.length,
                              itemBuilder: (context, index) {
                                final areadata = areaData![index];
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                        "Village name: ${areadata['village']}"),
                                    subtitle: Text(
                                        "Grower: ${areadata['grower']}\nArea: ${areadata['area']} acres"),
                                  ),
                                );
                              },
                            ),
                          ],
                          const SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              255, 146, 214, 148))),
                              onPressed: () {
                                surveyData['partition'] = selectedPartion;
                                surveyData['area'] = areaData;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AgricultureFormScreen(
                                              surveyData: surveyData,
                                            )));
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ])))));
  }
}
