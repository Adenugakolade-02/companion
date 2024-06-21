import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


Future<String> longLatAddress(LatLng? location) async{
   try {
    if(location==null){
      return "loading";
    }
    else{
      List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);

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
    return address;
  }

  } catch (e) {
    return "Unable to fetch Address";
    // return "No Address";
  }
  }