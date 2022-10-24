import 'package:flutter/material.dart';

class ServicesModel with ChangeNotifier{
  final String id,vehicleType,destination,availableSeat,capacity,serviceCategoryName,imageUrl,timing;
  final int price;

  ServicesModel({
      required this.id,
      required this.vehicleType,
      required this.destination,
      required this.availableSeat,
      required this.capacity,
      required this.serviceCategoryName,
      required this.imageUrl,
      required this.timing,
      required this.price});
}