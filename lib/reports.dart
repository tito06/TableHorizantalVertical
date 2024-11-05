import 'package:flutter/material.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  bool showAdvancedFields = false;

  //sample data
  List<String> dropdownItem1 = ['Option 1', 'Option 2', 'Option 3'];
  List<String> dropdownItem2 = ['Option 1', 'Option 2', 'Option 3'];
  List<String> dropdownItem3 = ['Option 1', 'Option 2', 'Option 3'];
  List<String> dropdownItem4 = ['Option 1', 'Option 2', 'Option 3'];
  List<String> dropdownItem5 = ['Option 1', 'Option 2', 'Option 3'];
  List<String> dropdownItem6 = ['Option 1', 'Option 2', 'Option 3'];
  List<String> dropdownItem7 = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Row: Dropdowns 1 and 2
              Row(
                children: [
                  Expanded(
                      child: _buildDropdownField("Report for", dropdownItem1)),
                  SizedBox(width: 16),
                  Expanded(
                      child: _buildDropdownField("Season Year", dropdownItem2)),
                ],
              ),
              SizedBox(height: 16),

              // Second Row: Dropdowns 3 and 4
              Row(
                children: [
                  Expanded(child: _buildDropdownField("Date", dropdownItem3)),
                  SizedBox(width: 16),
                  Expanded(
                      child: _buildDropdownField("Indent Type", dropdownItem4)),
                ],
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                      child: _buildDropdownField("Header 5", dropdownItem5)),
                  SizedBox(width: 16),
                  Expanded(
                      child: _buildDropdownField("Header 6", dropdownItem6)),
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

              // Advanced Fields (shown only if checkbox is checked)
              if (showAdvancedFields) ...[
                _buildDropdownField("Self Type", dropdownItem7),
                SizedBox(height: 16),
                Row(children: [
                  Expanded(child: _buildTextField("From Zone Code")),
                  SizedBox(width: 16),
                  Expanded(child: _buildTextField("To Zone Code"))
                ]),
                SizedBox(height: 16),
                Row(children: [
                  Expanded(child: _buildTextField("From Block Code")),
                  SizedBox(width: 16),
                  Expanded(child: _buildTextField("To Block Code"))
                ]),
                SizedBox(height: 16),
                Row(children: [
                  Expanded(child: _buildTextField("From Circle Code")),
                  SizedBox(width: 16),
                  Expanded(child: _buildTextField("To Circle Code"))
                ])
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (value) {
            // Handle dropdown value change
          },
        ),
      ],
    );
  }

  Widget _buildTextField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
