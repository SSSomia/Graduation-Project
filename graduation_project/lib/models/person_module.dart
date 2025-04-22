import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';

class PersonModule {
  late String personId;
  late String userName;
  late String name;
  late String password;
  late String phoneNumber = '';
  late String address = '';
  late String emial ;
  late DateTime createdAt;
  late String image = "https://creazilla-store.fra1.digitaloceanspaces.com/icons/3251108/person-icon-md.png";
  late String role;

  PersonModule(
    this.personId,
    this.userName,
    this.name,
    this.password,
    this.createdAt,
    this.emial,
    this.role
  );

  
}
