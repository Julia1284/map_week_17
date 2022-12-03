import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_week_17/home_page.dart';
import 'package:map_week_17/main.dart';
import 'package:map_week_17/models/position.dart';
import 'package:objectbox/objectbox.dart';

class MapPage extends StatefulWidget {
  Position position;
  MapPage(this.position, {Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Box<Position> positionBox = objectBox.store
      .box<Position>(); //обозначаем нашу таблицу с пользователями
  Location location = Location();
  late GoogleMapController _mapController;
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  List<LatLng> polylineCoordinates = [];

  Map<PolylineId, Polyline> polylines = {};

  void _onMapCreated(GoogleMapController mapController) {
    _controller.complete(mapController);
    _mapController = mapController;
  }

  _checkLocationPermission() async {
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
      if (!locationServiceEnabled) {
        return;
      }
    }

    PermissionStatus locationForAppStatus = await location.hasPermission();
    if (locationForAppStatus == PermissionStatus.denied) {
      await location.requestPermission();
      locationForAppStatus = await location.hasPermission();
      if (locationForAppStatus != PermissionStatus.granted) {
        return;
      }
    }
    LocationData locationData = await location.getLocation();
    _mapController.moveCamera(CameraUpdate.newLatLng(
        LatLng(locationData.latitude!, locationData.longitude!)));
    addCurrentMarker(locationData);
    addpPolyline(LatLng(widget.position.latitude, widget.position.longitude));
  }

  addCurrentMarker(currentPosition) {
    if (markers.isEmpty) {
      markers.add(Marker(
          markerId: const MarkerId("start"),
          infoWindow: const InfoWindow(title: "Start"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position:
              LatLng(currentPosition.latitude!, currentPosition.longitude!)));
      setState(() {});
    }
  }

  Future _addMarker(LatLng position) async {
    markers.add(Marker(
        markerId: const MarkerId('Start'),
        position: position,
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)));
    polylineCoordinates.clear();
    setState(() {});
  }

  Future addpPolyline(LatLng positionArg) async {
    if (positionArg.latitude == 0 || positionArg.longitude == 0) {
      return;
    } else {
      final points = PolylinePoints();
      final start = PointLatLng(
          markers.first.position.latitude, markers.first.position.longitude);
      markers.add(Marker(
          markerId: const MarkerId('Start'),
          position: positionArg,
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen)));
      final finish = PointLatLng(
          markers.last.position.latitude, markers.last.position.longitude);
      final result = await points.getRouteBetweenCoordinates(
          googleApiKey, start, finish,
          optimizeWaypoints: true);
      polylineCoordinates.clear();
      if (result.points.isNotEmpty) {
        result.points.forEach((point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      _addPolyLine();
    }
    setState(() {});
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    _checkLocationPermission();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map page"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(55.80, 37.52),
          zoom: 15,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: _onMapCreated,
        markers: markers,
        polylines: Set.of(polylines.values),
        onTap: _addMarker,
      ),
      floatingActionButton:
          // FloatingActionButtonLocation.startDocked
          FloatingActionButton(
        onPressed: () {
          positionBox.put(Position(
              latitude: markers.last.position.latitude,
              longitude: markers.last.position.longitude));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false);
        },
        child: const Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
