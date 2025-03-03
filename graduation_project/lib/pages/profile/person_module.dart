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
  late String emial = '';
  late DateTime createdAt;
  late File image;

  PersonModule(
    this.personId,
    this.userName,
    this.name,
    this.password,
    this.createdAt
  );

  
}
