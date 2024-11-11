import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportViewModel {
  List<String> items = [];
  final String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2NhbmVkZXYuYmlybGEtc3VnYXIuY29tL2FwaS9sb2dpbiIsImlhdCI6MTczMTEzNTE3NCwiZXhwIjoxNzMxNzM5OTc0LCJuYmYiOjE3MzExMzUxNzQsImp0aSI6IjFVRXJJOTBFZ0lXbGFvWVUiLCJzdWIiOiIyMDIxIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.TDw0usQ4B6OL_pi-2VJ5mxUkwA4NVK-mOLfmPUGcLi8";

  // A map to convert API field names to user-friendly labels
  final Map<String, String> headerMapping = {
    "id": "ID",
    "season": "Season",
    "mill_id": "Mill ID",
    "user_id": "User ID",
    "type_of_indent": "Indent Type",
    "plot_village_code": "Vill Code",
    "plot_village_name": "Vill Name",
    "plot_serial_no": "Plot No",
    "village_code": "Vill Code",
    "grower_code": "Grower Code",
    "land_type": "Land Type",
    "row_space": "Row Space",
    "planting_method": "Planting Method",
    "seed_source": "Source",
    "seed_type": "Seed Type",
    "variety_type": "Variety",
    "lease_or_own_land": "Lease/Own",
    "area_in_acre": "In acre",
    "area_in_hectare": "In Hectare",
    "indenting_date": "Indent Date",
    "expecting_planting_date": "Expecting Date",
    "created_at": "Created At",
    "updated_at": "Updated At",
    "V_ZONE": "Zone",
    "Z_LOCN": "Location",
    "zonal_incharge": "Zone Incharge",
    "BLK_NAME": "Block Name",
    "V_BLOCK": "Block",
    "block_incharge": "Block Incharge",
    "V_CIRCLE": "Circle",
    "CR_NAME": "Circle Name",
    "fds_incharge": "FDS",
    "village_name": "Village",
    "grower_name": "Grower Name",
    "grower_father_name": "Grower Father"
  };

  // API call to get the list of villages

  Future<List<Map<String, String>>> fetchVillages(
      Map<String, String> parameters) async {
    final response = await http.post(
      Uri.parse("https://canedev.birla-sugar.com/api/fetchVillage"),
      body: json.encode(parameters),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map<String, dynamic> && data['data'] is List) {
        final villages = data['data'] as List;
        // Map the list to extract both village code and name
        return villages.map((village) {
          return {
            'V_CODE': village['V_CODE'].toString(),
            'V_NAME': village['V_NAME'].toString(),
          };
        }).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Your API call method to send data and fetch report
  Future<List<Map<String, String>>> fetchReportData(
      Map<String, String> parameters) async {
    final url = Uri.parse('https://canedev.birla-sugar.com/api/report');

    try {
      final response = await http.post(
        url,
        body: json.encode(parameters),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("Parsed Report Data: $data");

        // If the data is a map and contains the 'data' key, return it
        if (data is Map<String, dynamic> && data.containsKey('data')) {
          var dataList = data['data'];
          if (dataList is Map) {
            // Handle case where 'data' is empty
            if (dataList.isEmpty) {
              print('No data found');
              return []; // Return an empty list if no data is found
            }
            // If the data is not empty and is a map, handle it
            return [];
          } else if (dataList is List) {
            return dataList.map((item) {
              if (item is Map<String, dynamic>) {
                // Convert each item into Map<String, String>
                return item.map((key, value) {
                  // Convert each value to a String, regardless of its type
                  // And map the key to a user-friendly name if it exists in the mapping
                  String displayValue = value == null ? '-' : value.toString();

                  String userFriendlyKey = headerMapping[key] ?? key;
                  return MapEntry(userFriendlyKey, displayValue);
                });
              } else {
                throw Exception('Unexpected item type in data list');
              }
            }).toList();
          } else {
            throw Exception('Data is not a list');
          }
        } else {
          throw Exception('Unexpected data format: Missing "data" list');
        }
      } else {
        throw Exception('Failed to fetch report data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching report data: $e');
    }
  }
}
