import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapSample extends StatefulWidget {
  final double lat;
  final double long;
  MapSample(this.lat, this.long);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();


Set<Marker>  _markers = {};


  Future<void> _onMapCreate(GoogleMapController controller) async {

     final _mark = Marker(
       infoWindow: InfoWindow(
         title: 'Risers',
       ),
       position: LatLng(widget.lat, widget.long),
         markerId: MarkerId('riser')
     );

     setState((){
        _markers.add(_mark);
     });

  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(
          target: LatLng(widget.lat, widget.long),
          zoom: 15.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _onMapCreate(controller);
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}