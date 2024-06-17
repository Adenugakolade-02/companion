import 'package:caution_companion/data/models/location_model.dart';
import 'package:caution_companion/data/models/report_model.dart';
import 'package:caution_companion/data/models/result.dart';

abstract class ReportRepository{
  Future<Result<List<ReportModel>>> getReports();
  Future<Result<bool>> postReport({
      required IncidentType incidentType,
      required LocationModel location,
      required String description
    });
}