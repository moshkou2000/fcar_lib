import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@immutable
class NotificationMessageModel {
  final int id;
  final String? title;
  final String? body;
  final NotificationDetails? notificationDetails;
  final String? payload;
  final Map<String, dynamic>? data;

  const NotificationMessageModel({
    required this.id,
    this.title,
    this.body,
    this.notificationDetails,
    this.payload,
    this.data,
  });
}
