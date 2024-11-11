import 'package:flutter/material.dart';
import 'package:my_reports/api_service.dart';
import 'package:my_reports/reportModel.dart';

class ReportDetailViewModel extends ChangeNotifier {
  final ApiService apiService;
  ReportDetailModel? reportDetail;
  bool isLoading = false;
  String? errorMessage;

  ReportDetailViewModel({required this.apiService});

  Future<void> fetchReportDetails() async {
    isLoading = true;
    notifyListeners();

    try {
      reportDetail = await apiService.fetchReportDetails();
      errorMessage = null;
    } catch (error) {
      errorMessage = 'Failed to load data';
      reportDetail = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
