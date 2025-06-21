import 'package:flutter/material.dart';
import 'package:graduation_project/models/store_info_model.dart';
import 'package:graduation_project/providers/register_provider.dart';
import 'package:graduation_project/providers/store_info_provider.dart';
import 'package:graduation_project/screens/auth/login_page.dart';
import 'package:provider/provider.dart';

class SellerMarketData extends StatefulWidget {
  SellerMarketData({
    super.key,
  });

  @override
  State<SellerMarketData> createState() => _SellerMarketDataState();
}

class _SellerMarketDataState extends State<SellerMarketData> {
  final _formKey = GlobalKey<FormState>();

  String? _nameError;
  String? _typeError;
  String? _descriptionError;

  final TextEditingController _conName = TextEditingController();
  final TextEditingController _conType = TextEditingController();
  final TextEditingController _conDescription = TextEditingController();

  @override
  void dispose() {
    _conDescription.dispose();
    _conName.dispose();
    _conType.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _descriptionError = _conDescription.text.isEmpty
          ? "Please enter market description"
          : null;
      _nameError = _conName.text.isEmpty ? "Please enter market name" : null;
      _typeError =
          _conType.text.isEmpty ? "Please enter your market type" : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final sellerProvider = Provider.of<SellersProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 200, 200),
            body: Center(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  Container(
                    width: 350,
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 123, 123, 123)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'STORE INFO',
                            style: TextStyle(
                                fontSize: 45,
                                color: Color.fromARGB(255, 185, 28, 28),
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, top: 10, bottom: 10),
                              child: TextFormField(
                                controller: _conName,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter market name";
                                  }
                                  return null;
                                },
                                //obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  prefixIcon: const Icon(Icons.abc_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  errorText: _nameError,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _nameError = value.isEmpty
                                        ? "Please enter your market name"
                                        : null;
                                  });
                                },
                              )),
                          Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 10, bottom: 10),
                            child: TextFormField(
                              controller: _conDescription,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a description";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Description',
                                prefixIcon:
                                    const Icon(Icons.description_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorText: _descriptionError,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _descriptionError = value.isEmpty
                                      ? "Please enter market description"
                                      : null;
                                });
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 10, bottom: 10),
                            child: TextFormField(
                              controller: _conType,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your market type";
                                }
                                return null;
                              },
                              //obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Store Type',
                                prefixIcon: const Icon(Icons.home_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorText: _typeError,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _typeError = value.isEmpty
                                      ? "Please enter your store type"
                                      : null;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: SizedBox(
                                  width: 300,
                                  height: 50,
                                  child: Consumer<StoreProvider>(
                                      builder: (context, store, child) {
                                    return ElevatedButton(
                                        onPressed: () async {
                                          // _validateForm();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final authProvider =
                                                Provider.of<UserProvider>(
                                                    context,
                                                    listen: false);

                                            await store.submitStore(
                                                StoreModel(
                                                    storeName: _conName.text,
                                                    storeDescription:
                                                        _conDescription.text,
                                                    storeType: _conType.text),
                                                authProvider.token);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginPage()));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Sign up market data successfully.')),
                                            );
                                            // sellerProvider.addSeller(
                                            //   Seller(
                                            //       person: widget.person,
                                            //       address: _conaddress.text,
                                            //       storeName: _conName.text,
                                            //       storeDescription:
                                            //           _conDescription.text,
                                            //       sellerID: sellerProvider
                                            //           .numberOfSellers
                                            //           .toString()),
                                            // );
                                            // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                            // sharedPreferences.setString("userName", "")
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(255, 185, 28, 28),
                                          foregroundColor: const Color.fromARGB(
                                              255,
                                              255,
                                              255,
                                              255), // Text (foreground) color of the button
                                        ),
                                        child: const Text(
                                          'Sign Up',
                                          style: TextStyle(fontSize: 20),
                                        ));
                                  }))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('You have an account?'),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                    );
                                  },
                                  child: const Text('Login'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ])))));
  }
}
