import 'package:caution_companion/data/models/location_model.dart';
import 'package:caution_companion/data/models/report_model.dart';
import 'package:caution_companion/data/models/result.dart';
import 'package:caution_companion/domain/report_repo.dart';
import 'package:caution_companion/services/http_service.dart';

class ReportRepositoryImpl implements ReportRepository{
  
  @override
  Future<Result<List<ReportModel>>> getReports() async{
    final response = await HttpService.get(HttpService.getReports, {});
    return response.when(
      success: (success){
        final reports = List.from(success["data"]["items"]).map((e) => ReportModel.fromJosn(e)).toList();
        return Result.success(reports);
      }, 
      error: (error)=> Result.error(CustomError.message(error.message))
    );
  }

  @override
  Future<Result<bool>> postReport({required IncidentType incidentType, required LocationModel location, required String description}) async{
    final response = await HttpService.post(HttpService.reports, {
      "incident_type": incidentType.name,
      "location":location.toJson(),
      "description":description
    });

    return response.when(success: (success)=>const Result.success(true), error: (error)=>Result.error(CustomError.message(error.message)));
  }
  
}