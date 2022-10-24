import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_travel_app/models/services_model.dart';

class ServicesProvider with ChangeNotifier {
  static List<ServicesModel> _servicesList = [];
  List<ServicesModel> get getServices {
    return _servicesList;
  }

  //====================fetch all data from firebase through provider==========================================
  Future<void> fetchServices() async {
    await FirebaseFirestore.instance
        .collection('services')
        .get()
        .then((QuerySnapshot servicesSnapshot) {
      _servicesList = [];
      servicesSnapshot.docs.forEach((element) {
        _servicesList.insert(
          0,
          ServicesModel(
              id: element.get('id'),
              vehicleType: element.get('vehicleType'),
              destination: element.get('destination'),
              availableSeat: element.get('availableSeat'),
              capacity: element.get('capacity'),
              serviceCategoryName: element.get('serviceCategoryName'),
              imageUrl: element.get('imageUrl'),
              timing: element.get('arrivalTime'),
              price: int.parse(element.get('ticket').toString())),
        );
      });
    });
    notifyListeners();
  }

  ServicesModel findServiceById(String serviceId) {
    return _servicesList.firstWhere((element) => element.id == serviceId);
  }

  List<ServicesModel> findByCategory(String categoryName) {
    List<ServicesModel> _categoryList = _servicesList
        .where((element) => element.serviceCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<ServicesModel> searchQuery(String searchText) {
    List<ServicesModel> _searchList = _servicesList
        .where((element) => element.destination
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }
}
