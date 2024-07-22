import 'dart:async';
import 'dart:developer';

import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/map/map_view_model.dart';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  Location locationController =  Location();
  LatLng? currentLocation;
  
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  final MapViewModel model = serviceLocator<MapViewModel>();
  
  @override
  void initState() {
    model.initializeMarkers();
    getLocationUpdates();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Scaffold(
        body: currentLocation==null
        ? const Center(child: CircularProgressIndicator.adaptive(),)
        : Consumer<MapViewModel>(
          builder: (_,model,__) {
            return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(target: currentLocation!, zoom: 13),
                onMapCreated: (GoogleMapController controller){
                  if(!_mapController.isCompleted){
                    _mapController.complete(controller);
                  }else{

                  }
                },
              
                markers: {
                  Marker(
                    markerId: const MarkerId("user_location"),
                    position: currentLocation!,
                    icon: BitmapDescriptor.defaultMarker
                    ),
                  ...model.markers
                },
                onTap: (_) async{
                  log("here is location ${_.latitude} ${_.longitude}");
                  // final addresses = await Geocodin.local.findAddressesFromCoordinates(_);
                  // model.printAddressOut(_);

                },
              );
          }
        )
      ),
    );
  }


  Future<void> getLocationUpdates() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    LocationData locationData = await locationController.getLocation();
    // locationData.
    setState(() {
          // currentLocation = const LatLng(20.566712, 78.957127);
          currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
          // model.setUserCurrentLocation(currentLocation!);
        });
    locationController.onLocationChanged.listen((LocationData location) { 
      if (location.latitude != null && location.longitude != null){
        setState(() {
          // currentLocation = LatLng(location.latitude!, location.longitude!);
          // log('$currentLocation');
                    // _cameraToPosition(currentLocation!);
          log(" here is location ${currentLocation.toString()}");

        });
      }
    });
  }
}