import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_back_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_text.dart';
import 'package:instrabaho_app/presentation/dashboard/pages/job_status_screen.dart';

class WorkerLocationScreen extends StatefulWidget {
  const WorkerLocationScreen({super.key});

  @override
  State<WorkerLocationScreen> createState() => _WorkerLocationScreenState();
}

class _WorkerLocationScreenState extends State<WorkerLocationScreen>
    with SingleTickerProviderStateMixin {
  late GoogleMapController mapController;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  Set<Circle> circles = {};
  bool isLoading = true;
  BitmapDescriptor? homeOwnerIcon;
  BitmapDescriptor? workerIcon;
  late AnimationController _animationController;

  // Mock locations
  final LatLng _myLocation = const LatLng(14.5995, 120.9842); // Manila
  final LatLng _workerLocation =
      const LatLng(14.6000, 120.9850); // Nearby Manila

  @override
  void initState() {
    super.initState();
    _setupAnimationController();
    _loadCustomMarkers();
  }

  void _setupAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animationController.addListener(() {
      _updateCircles();
    });
  }

  void _updateCircles() {
    final double radius =
        30 + (10 * math.sin(_animationController.value * 2 * math.pi));
    setState(() {
      circles = {
        Circle(
          circleId: const CircleId('workerRadius'),
          center: _workerLocation,
          radius: radius,
          fillColor: C.orange600.withOpacity(0.2),
          strokeColor: C.orange600.withOpacity(0.5),
          strokeWidth: 2,
        ),
        Circle(
          circleId: const CircleId('homeOwnerRadius'),
          center: _myLocation,
          radius: radius,
          fillColor: Colors.blue.withOpacity(0.2),
          strokeColor: Colors.blue.withOpacity(0.5),
          strokeWidth: 2,
        ),
      };
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadCustomMarkers() async {
    try {
      final Uint8List homeOwnerImageData =
          await _getBytesFromAsset('assets/map/home_owner.png', 120);
      final Uint8List workerImageData =
          await _getBytesFromAsset('assets/map/worker.png', 120);

      setState(() {
        homeOwnerIcon = BitmapDescriptor.fromBytes(homeOwnerImageData);
        workerIcon = BitmapDescriptor.fromBytes(workerImageData);
      });

      _createMarkers();
      _getRouteCoordinates();
    } catch (e) {
      print('Error loading custom markers: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _getRouteCoordinates() async {
    try {
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?origin=${_myLocation.latitude},${_myLocation.longitude}&destination=${_workerLocation.latitude},${_workerLocation.longitude}&key=AIzaSyAJaLAgURK1y5vH409o1qO8uG9yGe3bJFw'));
      log("Response ${response.body}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final points =
              _decodePolyline(data['routes'][0]['overview_polyline']['points']);
          setState(() {
            polylines.add(
              Polyline(
                polylineId: const PolylineId('route'),
                points: points,
                color: C.orange600,
                width: 5,
              ),
            );
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching route: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latDouble = lat / 1E5;
      double lngDouble = lng / 1E5;
      poly.add(LatLng(latDouble, lngDouble));
    }

    return poly;
  }

  void _createMarkers() {
    markers.add(
      Marker(
        markerId: const MarkerId('myLocation'),
        position: _myLocation,
        infoWindow: const InfoWindow(title: 'Your Location'),
        icon: homeOwnerIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );

    markers.add(
      Marker(
        markerId: const MarkerId('workerLocation'),
        position: _workerLocation,
        infoWindow: const InfoWindow(title: 'Worker Location'),
        icon: workerIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText.appBar(context, "Worker Location"),
        leading: CustomBackButton(),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _myLocation,
              zoom: 17,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            polylines: polylines,
            markers: markers,
            circles: circles,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            mapToolbarEnabled: true,
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding:
                    EdgeInsets.only(bottom: 30, top: 20, left: 20, right: 20),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText.notes(context, "Worker's Progress"),
                    Gap(8),
                    CustomText.caption(
                        context, "Worker is on the way to your location"),
                    Gap(8),
                    WorkerStatusLinearIndicator()
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
