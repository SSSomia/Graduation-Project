import 'package:graduation_project/models/person_module.dart';

class Seller {
  late String sellerID;
  PersonModule person;
  String address;
  String storeName;
  String storeDescription;

  Seller({
    required this.sellerID,
    required this.person,
    required this.address,
    required this.storeName,
    required this.storeDescription,
  });

  // Update seller details
  // void updateDetails({String? newAddress, String? newStoreName}) {
  //   if (newAddress != null) {
  //     address = newAddress;
  //   }
  //   if (newStoreName != null) {
  //     storeName = newStoreName;
  //   }
  // }
}
