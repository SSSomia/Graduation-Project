import 'package:graduation_project/pages/profile/person_module.dart';

//late PersonModule globalUser;

late GlobalUser globalUser;

class GlobalUser {
  String userID;
  late String name;
  late String userName;
  late String userPassword;
  late String userAddress;
  late String userPhone;
  late String userEmail;
  late DateTime createdAt;
  late String image =
      "https://creazilla-store.fra1.digitaloceanspaces.com/icons/3251108/person-icon-md.png";
  bool isSeller;
  String? marketName = '';
  String? marketAddress = '';
  String? marketDescription = '';

  GlobalUser(
      this.userID,
      this.name,
      this.userName,
      this.userPassword,
      this.createdAt,
      this.userAddress,
      this.userEmail,
      this.userPhone,
      this.isSeller,
      this.marketName,
      this.marketAddress,
      this.marketDescription);
}
