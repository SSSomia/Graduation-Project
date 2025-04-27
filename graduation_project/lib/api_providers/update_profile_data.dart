import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation_project/services/api_service.dart'; // Import the ProfileApi class

class UpdateProfileData with ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _userName = '';
  //String _password = '';
  File? _image; // Base64 encoded image string or image URL

  // Getters to access current profile data
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  //String get password => _password;
  File? get image => _image;
  String get userName => _userName;

  Future<bool> updateProfile({
    required String FirstN,
    required String LastN,
    required String Email,
    required String UserN,
    File? profileImage0, // Optional profile image
    required String token,
  }) async {
    try {
      final response = await ApiService.updateProfile(
        firstName: FirstN,
        lastName: LastN,
        email: Email,
        userName: UserN,
        profileImage: profileImage0,
        token: token,
      );

      // If successful, update local state
      _firstName = firstName;
      _lastName = lastName;
      _email = email;
      _userName = userName;
      _image = profileImage0;

      print(response);
      notifyListeners(); // Update UI
      return true;
    } catch (error) {
      print("Error updating profile: $error");
      return false;
    }
  }
}
