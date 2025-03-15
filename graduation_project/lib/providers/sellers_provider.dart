import 'package:flutter/material.dart';
import 'package:graduation_project/models/seller_model.dart';
import 'package:graduation_project/pages/profile/person_module.dart';

class SellersProvider extends ChangeNotifier {
  Map<String, Seller> sellers = {};
  int numberOfSellers = 0;
  Seller? _seller;

  // Get the seller
  Seller? get seller => _seller;
  addSeller(Seller seller) {
    sellers['$numberOfSellers'] = seller;
    numberOfSellers++;
    notifyListeners();
  }
    void updateSeller({String? address, String? storeName}) {
    if (_seller != null) {
      _seller!.updateDetails(newAddress: address, newStoreName: storeName);
      notifyListeners();
    }
  }

  Seller getSellerDataUsingUserName(String userName)
  {
    Seller? foundPerson = sellers.values.firstWhere(
    (person) => person.person.userName == userName);
    return foundPerson;
  }
}

