import 'package:flutter/material.dart';
import 'package:graduation_project/api_models/register.dart';
import 'package:graduation_project/services/api_service.dart';



class UserProvider with ChangeNotifier {
  User? _user;
    String _token = '';
  bool _isAuthenticated = false;

  String get token => _token;
  bool get isAuthenticated => _isAuthenticated;
  User? get user => _user;


  Future<void> register(
      {required User user}) async {
    final result = await ApiService().register(
        user: user);

    if (result != null && result.containsKey('token')) {
      _token = result['token'];
      _isAuthenticated = true;
      notifyListeners();
    } else {
      // Handle registration failure
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}



// class UserProvider with ChangeNotifier {
//   final ApiService _apiService = ApiService();

//   String _token = '';
//   bool _isAuthenticated = false;
//   User? _user;

//   String get token => _token;
//   bool get isAuthenticated => _isAuthenticated;
//   User? get User => _user;

//   Future<void> register(
//       {required String FirstName,
//       required String LastName,
//       required String UserName,
//       required String Email,
//       required String Password,
//       required String Role}) async {
//     final result = await ApiService().register(
//         FirstName: FirstName,
//         LastName: LastName,
//         UserName: UserName,
//         Email: Email,
//         Password: Password,
//         Role: Role);

//     if (result != null && result.containsKey('token')) {
//       _token = result['token'];
//       _isAuthenticated = true;
//       notifyListeners();
//     } else {
//       // Handle registration failure
//     }
//   }
// }

// // class SignupProvider extends ChangeNotifier {
// //   final ApiService _apiService = ApiService();

// //   bool _isLoading = false;
// //   String? _error;
// //   User? _user;

// //   bool get isLoading => _isLoading;
// //   String? get error => _error;
// //   User? get user => _user;

// //   Future<void> signUp(String name, String email, String password) async {
// //     _isLoading = true;
// //     _error = null;
// //     notifyListeners();

// //     try {
// //       _user = await _apiService.register(
// //           name: name, email: email, password: password);
// //     } catch (e) {
// //       _error = e.toString();
// //     }

// //     _isLoading = false;
// //     notifyListeners();
// //   }
// // }