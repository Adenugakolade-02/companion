import 'package:caution_companion/data/models/location_model.dart';
import 'package:caution_companion/data/models/report_model.dart';
import 'package:caution_companion/data/repos/report_repo_impl.dart';
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/services/dialog_service.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum ReportStates{
  idle, 
  loading,
  fail
}
class ReportViewModel extends ChangeNotifier{

  ReportStates state = ReportStates.idle;
  final DialogService dialogService = serviceLocator<DialogService>();

  final reportRepositoryImpl = ReportRepositoryImpl();
  
  

  

  List<ReportModel> reportList = [];
  

  Future<bool> fetchReports() async{
    setState(ReportStates.loading);

    final response = await reportRepositoryImpl.getReports();
    setState(ReportStates.idle);
    return response.when(success: (success){
      reportList = success;
      notifyListeners();
      return true;
    }, error: (error){
        setState(ReportStates.fail);
        dialogService.displayMessage(error.message,);
        return false;
      }
    );
  }
  void createReport({required IncidentType incidentType, required LatLng location, required String description}) async{
    setState(ReportStates.loading);
    final response = await reportRepositoryImpl.postReport(incidentType: incidentType, location: LocationModel(longitude: location.longitude, latitude: location.latitude), description: description);
    setState(ReportStates.idle);
    response.when(
      success: (success){
        dialogService.displayMessage("Report created successfully", status: Status.success);
        AppRoute.pop();
        fetchReports();
      }, 
      error: (error){
        dialogService.displayMessage("Failed to create report, try again");
      }
    );
  }
  void setState(ReportStates newState){
    state = newState;
    notifyListeners();
  }
}