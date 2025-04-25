import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation_project/services/api_service.dart'; // Import the ProfileApi class

class UpdateProfileData with ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  String _image = ''; // Base64 encoded image string or image URL

  // Getters to access current profile data
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get password => _password;
  String get image => _image;

  // Method to update the profile data
  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required File? profileImage, // Optional profile image
  }) async {
    try {
      // Call the ProfileApi class to update the profile
      Map<String, dynamic> response = await ApiService.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        profileImage: profileImage,
      );

      // If the update was successful, update local state
      if (response['success'] == true) {
        _firstName = firstName;
        _lastName = lastName;
        _email = email;
        _password = password;
        if (profileImage != null) {
          _image = base64Encode(profileImage.readAsBytesSync()); // Save the base64 image
        }

        notifyListeners(); // Notify listeners to update the UI
        return true;
      } else {
        return false; // API failed (e.g., invalid data)
      }
    } catch (error) {
      print("Error updating profile: $error");
      return false; // Handle network errors or other exceptions
    }
  }
}
