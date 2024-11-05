import 'package:flutter/material.dart';

class InputFields extends StatelessWidget {
  final List<String> names;
  final List<String> years;
  final List<String> types;
  final String? selectedName;
  final String? selectedYear;
  final String? selectedTypeFrom;
  final String? selectedTypeTo;
  final Function(String?) onNameChanged;
  final Function(String?) onYearChanged;
  final Function(String?) onTypeFromChanged;
  final Function(String?) onTypeToChanged;

  InputFields({
    required this.names,
    required this.years,
    required this.types,
    required this.selectedName,
    required this.selectedYear,
    required this.selectedTypeFrom,
    required this.selectedTypeTo,
    required this.onNameChanged,
    required this.onYearChanged,
    required this.onTypeFromChanged,
    required this.onTypeToChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Name Dropdown
              Flexible(
                child: Container(
                    width: 200,
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      ),
                      value: selectedName,
                      items: names.map((name) {
                        return DropdownMenuItem<String>(
                          value: name,
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13),
                          ),
                        );
                      }).toList(),
                      onChanged: onNameChanged,
                    )),
              ),
              SizedBox(
                width: 8,
              ),
              // Year Dropdown
              Flexible(
                child: Container(
                    width: 100,
                    // Set a fixed width for the TextField
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Year',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      ),
                      value: selectedYear,
                      items: years.map((year) {
                        return DropdownMenuItem<String>(
                          value: year,
                          child: Text(year,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 13)),
                        );
                      }).toList(),
                      onChanged: onYearChanged,
                    )),
              ),
              // Date Input (smaller TextField)

              SizedBox(
                width: 8,
              ),

              Container(
                width: 150,
                // Set a fixed width for the TextField
                child: // Set a fixed width for the TextField
                    TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Type From Dropdown
              Flexible(
                child: Container(
                    width: 200, // Set a fixed width for the TextField
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Type From',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      ),
                      value: selectedTypeFrom,
                      items: types.map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 13)),
                        );
                      }).toList(),
                      onChanged: onTypeFromChanged,
                    )),
              ),
              SizedBox(width: 8),
              // Type To Dropdown
              Flexible(
                child: Container(
                    width: 200,
                    // Set a fixed width for the TextField
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Type To',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      ),
                      value: selectedTypeTo,
                      items: types.map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 13)),
                        );
                      }).toList(),
                      onChanged: onTypeToChanged,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
