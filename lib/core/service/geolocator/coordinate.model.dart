import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

@immutable
class CoordinateModel {
  final double latitude;
  final double longitude;

  const CoordinateModel({
    required this.latitude,
    required this.longitude,
  });

  factory CoordinateModel.fromPosition(Position position) {
    return CoordinateModel(
        latitude: position.latitude, longitude: position.longitude);
  }
}
