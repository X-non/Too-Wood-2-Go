import 'package:eatwise/backend/maps.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/models/company_notifier.dart';
import 'package:eatwise/models/distance_notifier.dart';
import 'package:eatwise/widgets/ew_company_list_small.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _position;
  List<CompanyItem> nearbyCompanies = [];

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
          _position = LatLng(position.latitude, position.longitude);
        });
        updateNearbyCompanies();
      }
    } catch (e) {}
  }

  void updateCurrentLocation(Position position) {
    if (mounted) {
      setState(() {
        _position = LatLng(position.latitude, position.longitude);
      });
      updateNearbyCompanies();
    }
  }

  void updateNearbyCompanies() async {
    List<CompanyItem> companies =
        Provider.of<CompanyNotifier>(context, listen: false).companyItem;
    nearbyCompanies.clear();
    for (var company in companies) {
      try {
        List<Location> coordinates = await locationFromAddress(company.address);
        LatLng companyPosition =
            LatLng(coordinates[0].latitude, coordinates[0].longitude);
        double distance = Geolocator.distanceBetween(
          _position!.latitude,
          _position!.longitude,
          companyPosition.latitude,
          companyPosition.longitude,
        );
        if (distance <=
            Provider.of<DistanceNotifier>(context, listen: false).distance) {
          nearbyCompanies.add(company);
        }
      } catch (e) {
        print('Error fetching location for ${company.title}: $e');
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.map_outlined,
              size: 50,
              color: EWColors.darkgreen,
            ),
          ),
          SizedBox(
            child: Text(
              "Karta",
              style: EWTextStyles.titleBold,
            ),
          ),
        ],
      ),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: EWMap(onSliderChanged: (double value) {
                      updateNearbyCompanies();
                    })),
              ))),
      const Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              "Butiker i din närhet",
              style: EWTextStyles.headline,
            ),
          ),
        ],
      ),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: EwCompanyListSmall(items: nearbyCompanies),
      ),
    ]);
  }
}
