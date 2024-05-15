import 'dart:async';

import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/models/company_notifier.dart';
import 'package:eatwise/models/distance_notifier.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class EWMap extends StatefulWidget {
  final Function(double) onSliderChanged;

  const EWMap({super.key, required this.onSliderChanged});

  @override
  State<EWMap> createState() => EWMapState();
}

class EWMapState extends State<EWMap> {
  void onSliderChanged(double value) {
    Provider.of<DistanceNotifier>(context, listen: false)
        .updateDistance(value * 1000);
  }

  final Completer<GoogleMapController> _controller = Completer();

  LatLng? _currentPosition;

  Set<Marker> markers = {};

  double _currentSliderValue = 2;

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
      addShopToMap();
    }
  }

  void updateCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newLatLng(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude)));
  }

  void addShopToMap() async {
    markers.clear();
    List<CompanyItem> companies =
        Provider.of<CompanyNotifier>(context, listen: false).companyItem;
    for (var company in companies) {
      List<Location> coordinates = await locationFromAddress(company.address);
      LatLng companyPosition =
          LatLng(coordinates[0].latitude, coordinates[0].longitude);
      double distanceBetween = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          companyPosition.latitude,
          companyPosition.longitude);

      if (distanceBetween <=
          Provider.of<DistanceNotifier>(context, listen: false).distance) {
        markers.add(Marker(
          markerId: MarkerId(company.title),
          position: companyPosition,
          infoWindow: InfoWindow(
            title: company.title,
            snippet: company.description,
          ),
        ));
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        flex: 10,
        child: _currentPosition == null
            ? const Center(
                child: Text(
                "Laddar...",
                style: EWTextStyles.body,
              ))
            : GoogleMap(
                myLocationEnabled: true,
                markers: markers,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude),
                  zoom: 13,
                ),
                compassEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                circles: {
                  Circle(
                    strokeColor: EWColors.primary,
                    circleId: const CircleId('currentCircle'),
                    center: LatLng(_currentPosition!.latitude,
                        _currentPosition!.longitude),
                    radius:
                        Provider.of<DistanceNotifier>(context, listen: false)
                            .distance,
                    strokeWidth: 1,
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  addShopToMap();
                },
              ),
      ),
      Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Slider(
                    thumbColor: EWColors.primary,
                    activeColor: EWColors.primary,
                    value: _currentSliderValue,
                    min: 0.5,
                    max: 5,
                    divisions: 9,
                    label: _currentSliderValue.toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                        addShopToMap();
                        onSliderChanged(value);
                        widget.onSliderChanged(value);
                      });
                    }),
              ),
              const Text("(KM)"),
            ],
          ))
    ]));
  }
}
