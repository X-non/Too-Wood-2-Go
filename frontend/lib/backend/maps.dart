import 'dart:async';

import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//TODO: Add coordinates as field for comapanyItem

class EWMap extends StatefulWidget {
  const EWMap({super.key});

  @override
  State<EWMap> createState() => EWMapState();
}

class EWMapState extends State<EWMap> {
  final Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController _googleMapController;

  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    requestPermission();

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best, distanceFilter: 10),
    ).listen((Position newPosition) {
      updateCurrentLocation(newPosition);
    });
  }

  Future<void> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Future.error('Plats har inte delas');
    } else if (permission == LocationPermission.deniedForever) {
      Future.error('Plats är inte delad någonsin');
    }
    {
      getCurrentLocation();
    }
  }

  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
        });
      }
    } catch (e) {}
  }

  void updateCurrentLocation(Position position) {
    if (mounted) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
      updateCameraPosition();
    }
  }

  void updateCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newLatLng(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude)));
  }

  void addShopToMap(CompanyItem company) {
    Marker(
      markerId: MarkerId(company.title),
      position: const LatLng(59.84972, 17.63889),
      infoWindow:
          InfoWindow(title: company.title, snippet: company.description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _currentPosition == null
            ? const Center(
                child: Text(
                "Laddar...",
                style: EWTextStyles.body,
              ))
            : GoogleMap(
                myLocationEnabled: true,
                onTap: (latLng) {
                  if (mounted) {
                    setState(() {
                      _currentPosition = latLng;
                    });
                  }
                },
                markers: _currentPosition != null
                    ? {
                        Marker(
                            markerId: const MarkerId('value'),
                            position: _currentPosition!)
                      }
                    : {},
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude),
                  zoom: 12,
                ),
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ));
  }
}
