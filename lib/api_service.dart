import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_reports/reportModel.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<ReportDetailModel> fetchReportDetails() async {
    final response = await http.get(Uri.parse('$baseUrl/report-details'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ReportDetailModel.fromJson(data);
    } else {
      throw Exception('Failed to load report details');
    }
  }
}
