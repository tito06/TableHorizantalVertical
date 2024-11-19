import 'package:flutter/material.dart';
import 'package:my_reports/partition.dart';

class AreaScreen extends StatefulWidget {
  final double balanceArea;

  AreaScreen({required this.balanceArea});

  @override
  _AreaScreenState createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  // List to hold added data
  final List<Map<String, dynamic>> _areaData = [];

  // Controllers for dialog form
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _growerController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  bool _isUnknownGrower = false;

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Area Details"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _villageController,
                  decoration: InputDecoration(
                    labelText: "Village Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _growerController,
                  decoration: InputDecoration(
                    labelText: "Grower Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _isUnknownGrower,
                      onChanged: (bool? value) {
                        setState(() {
                          _isUnknownGrower = value!;
                        });
                      },
                    ),
                    Text("Unknown Grower"),
                  ],
                ),
                TextField(
                  controller: _areaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Area",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _addAreaData();
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _addAreaData() {
    setState(() {
      _areaData.add({
        'village': _villageController.text,
        'grower': _isUnknownGrower ? 'Unknown' : _growerController.text,
        'area': double.tryParse(_areaController.text) ?? 0.0,
      });
      // Clear form after adding
      _villageController.clear();
      _growerController.clear();
      _areaController.clear();
      _isUnknownGrower = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalArea = _areaData.fold(0.0, (sum, item) => sum + item['area']);

    return Scaffold(
      appBar: AppBar(
        title: Text("Area Management"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Balance Area: ${100 - widget.balanceArea}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Total Area: $totalArea",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showAddDialog,
              child: Text("Add Area"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _areaData.isEmpty
                  ? const Center(
                      child: Text(
                        "No area data added yet.",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _areaData.length,
                      itemBuilder: (context, index) {
                        final item = _areaData[index];
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            title: Text("Village: ${item['village']}"),
                            subtitle: Text(
                              "Grower: ${item['grower']}\nArea: ${item['area']} acres",
                            ),
                          ),
                        );
                      },
                    ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _areaData);
              },
              child: Text("Add "),
            ),
          ],
        ),
      ),
    );
  }
}
