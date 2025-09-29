import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:velocimetro/models/speedmeter_data.dart';
import 'package:flutter/services.dart';

class SpeedometerViewModel extends ChangeNotifier {
  SpeedometerData _speedometerData = SpeedometerData();
  Position? _lastPosition;
  StreamSubscription<Position>? _positionStreamSubscription;
  bool _isHudMode = false;

  SpeedometerData get data => _speedometerData;
  bool get isHudMode => _isHudMode;

  SpeedometerViewModel() {
    _checkAndRequestPermissions();
  }

  void toggleHudMode() {
    _isHudMode = !_isHudMode;

    if (_isHudMode) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    notifyListeners();
  }

  void resetDistance() {
    _speedometerData = SpeedometerData(
      currentSpeed: _speedometerData.currentSpeed,
      totalDistance: 0.0,
    );
    _lastPosition = null;
    notifyListeners();
  }

  Future<void> _checkAndRequestPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      _startTracking();
    } else {
      print("Permissão de localização negada pelo usuário.");
    }
  }

  void _startTracking() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );

    _positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position position) {
            double rawSpeedKmh = position.speed * 3.6;

            double newSpeed = (rawSpeedKmh < 1.5) ? 0.0 : rawSpeedKmh;

            double newDistance = _speedometerData.totalDistance;

            if (_lastPosition != null && newSpeed > 0) {
              double distanceInMeters = Geolocator.distanceBetween(
                _lastPosition!.latitude,
                _lastPosition!.longitude,
                position.latitude,
                position.longitude,
              );
              newDistance += distanceInMeters / 1000;
            }

            _lastPosition = position;

            _speedometerData = SpeedometerData(
              currentSpeed: newSpeed,
              totalDistance: newDistance,
            );

            notifyListeners();
          },
        );
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();

    SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    super.dispose();
  }
}
