import 'package:caution_companion/data/models/location_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/report_model.g.dart';

enum IncidentType {
  robbery("Robbery"), 
  fire("Fire"), 
  accident("Accident"), 
  cult("Cult Clash");

  final String value;
  const IncidentType(this.value) ;
  }

@JsonSerializable()
class ReportModel extends Equatable {
  final String id;
  final IncidentType incidentType;
  final String description;
  final LocationModel location;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReportModel({required this.id,
      required this.incidentType,
      required this.description,
      required this.location,
      required this.createdAt,
      required this.updatedAt
      });
  
  factory ReportModel.fromJosn(Map<String, dynamic> json){
    json['incidentType'] ??= json["incident_type"];
    json['createdAt'] ??= json["created_at"];
    json["updatedAt"] ??= json["updated_at"];
    return _$ReportModelFromJson(json);
  }

  @override
  List<Object?> get props => [id];
}



