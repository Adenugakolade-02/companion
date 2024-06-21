import 'package:google_maps_flutter/google_maps_flutter.dart';

class IncidentModel{
  final String? locationAddress;
  final LatLng? location;

  IncidentModel({required this.locationAddress, required this.location});
}