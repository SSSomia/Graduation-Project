class StoreModel {
  final String storeName;
  final String storeDescription;
  final String storeType;

  StoreModel({
    required this.storeName,
    required this.storeDescription,
    required this.storeType,
  });

  Map<String, dynamic> toJson() {
    return {
      'storeName': storeName,
      'storeDescription': storeDescription,
      'storeType': storeType,
    };
  }
}
