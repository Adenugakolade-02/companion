// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      id: json['id'] as String,
      incidentType: $enumDecode(_$IncidentTypeEnumMap, json['incidentType']),
      description: json['description'] as String,
      location:
          LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'incidentType': _$IncidentTypeEnumMap[instance.incidentType]!,
      'description': instance.description,
      'location': instance.location.toJson(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$IncidentTypeEnumMap = {
  IncidentType.robbery: 'robbery',
  IncidentType.fire: 'fire',
};
