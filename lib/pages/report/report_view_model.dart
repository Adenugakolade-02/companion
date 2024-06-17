import 'package:caution_companion/base_model.dart';
import 'package:caution_companion/data/models/report_model.dart';
import 'package:caution_companion/data/repos/report_repo_impl.dart';
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/services/dialog_service.dart';
import 'package:flutter/material.dart';

enum ReportStates{
  idle, 
  loading,
  fail
}
class ReportViewModel extends ChangeNotifier{

  ReportStates state = ReportStates.idle;
  final DialogService dialogService = serviceLocator<DialogService>();

  final reportRepositoryImpl = ReportRepositoryImpl();
  
  final List<String> reports = ["Theft", "Suicide","Fight","Murder"];

  

  List<ReportModel> reportList = [];
  

  void fetchReports() async{
    setState(ReportStates.loading);

    final response = await reportRepositoryImpl.getReports();
    setState(ReportStates.idle);
    response.when(success: (success){
      reportList = success;
      notifyListeners();
    }, error: (error){
        setState(ReportStates.fail);
        dialogService.displayMessage(error.message,);
      }
    );
  }


  void setState(ReportStates newState){
    state = newState;
    notifyListeners();
  }
}