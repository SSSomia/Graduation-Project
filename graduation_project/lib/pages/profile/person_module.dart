class PersonModule {
  late String personId;
  late String userName;
  late String name;
  late String password;
  late String phoneNumber = '';
  late String address = '';
  late String emial = '';
  late DateTime createdAt;

  PersonModule(
    this.personId,
    this.userName,
    this.name,
    this.password,
    this.createdAt
  );

  
}
