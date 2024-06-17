import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'generated/location_model.g.dart';

@JsonSerializable()
class LocationModel{
  final double longitude;
  final double latitude;

  LocationModel({required this.longitude, required this.latitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  Map<String, dynamic> toJson()=>_$LocationModelToJson(this);

  LatLng toCoordinates()=>LatLng(latitude, longitude);
}