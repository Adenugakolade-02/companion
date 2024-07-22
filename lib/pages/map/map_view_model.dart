import 'dart:developer';

import 'package:caution_companion/base_model.dart';
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/report/report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class MapViewModel extends BaseModel {
  final reportModel = serviceLocator<ReportViewModel>();
  Set<Marker> markers = {};

  void initializeMarkers() async {
    for (int i = 0; i < reportModel.reportList.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(reportModel.reportList[i].id),
          position: reportModel.reportList[i].location.toCoordinates(),
          icon: await Image.asset("assets/images/report marker.png",).toBitmapDescriptor(imageSize: const Size(150, 150))
          // await BitmapDescriptor.fromAssetImage(
              // const ImageConfiguration(), "assets/images/report marker.png"),
          // onTap: () {}
        ));
    }
    notifyListeners();
  }
}
