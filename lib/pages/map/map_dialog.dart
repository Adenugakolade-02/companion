import 'dart:async';
import 'package:caution_companion/data/models/incident_model.dart';
import 'package:caution_companion/helpers/long_lat_address.dart';
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/map/map_view_model.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapDialog extends StatefulWidget {
  const MapDialog({super.key});

  @override
  State<MapDialog> createState() => _MapDialogState();
}

class _MapDialogState extends State<MapDialog> {
  Location locationController =  Location();
  LatLng? currentLocation;
  LatLng? selectedLocation;
  String? selectedAddress;

  Marker selectedLocationMarker = Marker(
    markerId: const MarkerId("incident_location"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
  );

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  final MapViewModel model = serviceLocator<MapViewModel>();

  @override
  void initState() {
    getLocationUpdates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: screenSize.height/1.18,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: grey100
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Kindly Select location on the map"),
              const SizedBox(height: 10,),
              SizedBox(
                height: screenSize.height/1.5,
                child: currentLocation==null
                  ? const Center(child: CircularProgressIndicator.adaptive(),)
                  : GoogleMap(
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
                          selectedLocationMarker
                        // ...snapshot.data!
                      },
                      onTap: (location) async{
                        // final addresses = await Geocodin.local.findAddressesFromCoordinates(_);
                        setState(() {
                          selectedLocation = location;
                          selectedLocationMarker = Marker(
                            markerId: const MarkerId("incident_location"),
                            position: location,
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
                          );
                        });

                      },
                    ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: FutureBuilder<String>(
                  future: longLatAddress(selectedLocation),
                  builder: (_, snapshot){
                    if(snapshot.connectionState==ConnectionState.done){
                      selectedAddress = snapshot.data!;
                      return Text(snapshot.data!, style: TextStyle(fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey900),);
                    }else{
                      return const Text("...");
                    }
                  },
                  ),
              ),
              ElevatedButton(onPressed: (){
                    AppRoute.pop(IncidentModel(locationAddress: selectedAddress, location: selectedLocation));
                  }, child: const Text("Select Address")),
              const SizedBox(width: 10,)
          ]),
        ),
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
          currentLocation = LatLng(location.latitude!, location.longitude!);
          // log('$currentLocation');
                    // _cameraToPosition(currentLocation!);

        });
      }
    });
  }
}