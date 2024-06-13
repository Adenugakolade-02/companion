import 'dart:developer';

import 'package:caution_companion/base_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewModel extends BaseModel{



  void printAddressOut(LatLng _) async{
   try {
    List<Placemark> placemarks = await placemarkFromCoordinates(_.latitude, _.longitude);

    var address = '';

    if (placemarks.isNotEmpty) {

      // Concatenate non-null components of the address
      var streets = placemarks.reversed
          .map((placemark) => placemark.street)
          .where((street) => street != null);

      // Filter out unwanted parts
      streets = streets.where((street) =>
          street!.toLowerCase() !=
          placemarks.reversed.last.locality!
              .toLowerCase()); // Remove city names
      streets =
          streets.where((street) => !street!.contains('+')); // Remove street codes

      address += streets.join(', ');

      address += ', ${placemarks.reversed.last.subLocality ?? ''}';
      address += ', ${placemarks.reversed.last.locality ?? ''}';
      address += ', ${placemarks.reversed.last.subAdministrativeArea ?? ''}';
      address += ', ${placemarks.reversed.last.administrativeArea ?? ''}';
      address += ', ${placemarks.reversed.last.postalCode ?? ''}';
      address += ', ${placemarks.reversed.last.country ?? ''}';
    }

    log("Your Address for  is: $address");

    // return address;
  } catch (e) {
    log("Error getting placemarks: $e");
    // return "No Address";
  }
  }
}