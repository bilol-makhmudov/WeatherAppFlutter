import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/location.dart';
import 'constraints/constants.dart';

class Map extends StatefulWidget {
  const Map({super.key});
  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late MapController _mapController;

  @override
  double latitude = lat;
  double longitude = long;
  void initState() {
    // TODO: implement initState
    super.initState();

    _mapController = MapController();
  }

  void mapCenterChange() {
    _mapController.move(LatLng(latitude, longitude), 10);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: LatLng(latitude, longitude),
            minZoom: 5,
            maxZoom: 10,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                        onPressed: () {
                          Location().getCurrentLocation();
                          setState(() {
                            mapCenterChange();
                          });
                        },
                        icon: Icon(Icons.location_searching_outlined)),
                  )),
            ),
            // CurrentLocationLayer(
            //   centerOnLocationUpdate: CenterOnLocationUpdate.always,
            //   turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
            //   style: const LocationMarkerStyle(
            //     marker: DefaultLocationMarker(
            //       child: Icon(
            //         Icons.navigation,
            //         color: Colors.white,
            //       ),
            //     ),
            //     markerSize: Size(40, 40),
            //     markerDirection: MarkerDirection.heading,
            //   ),
            // )
          ],
        ),
      ),
    ));
  }

  // Future<void> locationDetect() async {
  //   Location location = Location();
  //   await location.getCurrentLocation();
  //   long = location.long;
  //   lat = location.lat;
  // }
}
