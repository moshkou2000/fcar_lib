import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import 'coordinate.model.dart';

/// Request for location permission grop from package [permission_handler].
///
/// [geolocator] is the LocationManager.
///
/// [radius] is meter.
/// It's better to not set lower than 5 meter.
///
/// [pointsOfInterest] is a geographical location represented in terms of longitude and latitude.
/// It can be a dealer location, store, building, etc.
///
/// [distance] is a distance between two coordinates in meter.
///
/// [inRange] is to determine that the given coordinate is in the range of the point of interests.
///
@immutable
abstract final class Geolocators {
  /// Use the geolocator for:
  /// - getCurrentPosition
  /// - getLastKnownPosition
  /// - getLocationAccuracy
  /// - config LocationSettings
  /// - isLocationServiceEnabled
  /// - listen to getPositionStream
  /// - listen to getServiceStatusStream
  static const geolocator = Geolocator;

  /// Estimated GPS accuracy (meter)
  static const double estimatedAccuracy = 5.0;

  static double _radius = estimatedAccuracy;

  /// It should satisfy the GPS accuracy [estimatedAccuracy] (meter)
  static set radius(double value) =>
      _radius = value > estimatedAccuracy ? value : estimatedAccuracy;

  /// Array of longitude & latitude
  /// Set the points of interest
  static List<CoordinateModel> pointsOfInterest = [];

  /// It returns in angle (direction)
  /// The supplied coordinates [start] & [end] must be in degrees.
  static double bearing({
    required CoordinateModel start,
    required CoordinateModel end,
  }) =>
      Geolocator.bearingBetween(
          start.latitude, start.longitude, end.latitude, end.longitude);

  /// It returns in meter
  /// The supplied coordinates [start] & [end] must be in degrees.
  static double distance({
    required CoordinateModel start,
    required CoordinateModel end,
  }) =>
      Geolocator.distanceBetween(
          start.latitude, start.longitude, end.latitude, end.longitude);

  /// [inRange] is TRUE when the coordinate is within a range of points of interest.
  ///
  /// Distance between coordinate and any of points of interest is less or equals to the radius.
  ///
  /// - It uses device current position if [coordinate] is not provided.
  /// - It uses [Geolocators.pointsOfInterest] if [pointsOfInterest] is not provided.
  /// - It uses [Geolocators.radius] if [radius] is not provided.
  ///   It should satisfy the GPS accuracy [estimatedAccuracy].
  static Future<bool> inRange({
    CoordinateModel? coordinate,
    List<CoordinateModel>? pointsOfInterest,
    double? radius,
    LocationAccuracy desiredAccuracy = LocationAccuracy.high,
  }) async {
    final c = coordinate ??
        CoordinateModel.fromPosition(await Geolocator.getCurrentPosition(
            desiredAccuracy: desiredAccuracy));
    final poi = pointsOfInterest ?? Geolocators.pointsOfInterest;
    final r = radius ?? Geolocators._radius;
    return poi.any((e) => Geolocators.distance(start: c, end: e) <= r);
  }
}
