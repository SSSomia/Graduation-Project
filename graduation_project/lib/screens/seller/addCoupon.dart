import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduation_project/models/dicount_seller_model.dart';
import 'package:graduation_project/providers/discount_seller_provider.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateCouponPage extends StatefulWidget {
  final int buyerId;
  final String buyerName;

  const CreateCouponPage({required this.buyerId, required this.buyerName});

  @override
  State<CreateCouponPage> createState() => _CreateCouponPageState();
}

class _CreateCouponPageState extends State<CreateCouponPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  DateTime? _expiryDate;
  bool _isLoading = false;

  Future<void> _pickExpiryDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  void _submitCoupon() async {
    FocusScope.of(context).unfocus(); // Hides keyboard safely

    if (_formKey.currentState!.validate() && _expiryDate != null) {
      setState(() => _isLoading = true);

      final code = _codeController.text.trim();
      final discount = int.parse(_discountController.text.trim());
      final expiry = _expiryDate!;

      final discountData = Discount(
        userId: widget.buyerId,
        couponCode: _codeController.text.trim(),
        discountPercentage: discount,
        expiryDate: expiry,
      );

      final authProvider = Provider.of<LoginProvider>(context, listen: false);

      final success =
          await Provider.of<DiscountProvider>(context, listen: false)
              .sendDiscount(discount: discountData, token: authProvider.token);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Coupon created for ${widget.buyerName}')),
        );
        Navigator.pop(context);
      } else {
        final error =
            Provider.of<DiscountProvider>(context, listen: false).errorMessage;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error ?? 'Failed to send coupon')),
        );
      }
    } else if (_expiryDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an expiry date.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final expiryDateText = _expiryDate != null
        ? DateFormat('yyyy-MM-dd').format(_expiryDate!)
        : 'Select Expiry Date';

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Coupon for ${widget.buyerName}'),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildInputCard(
                  child: TextFormField(
                    controller: _codeController,
                    decoration: const InputDecoration(
                      labelText: 'Coupon Code',
                      border: InputBorder.none,
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? 'Enter a coupon code'
                            : null,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  child: TextFormField(
                    controller: _discountController,
                    decoration: const InputDecoration(
                      labelText: 'Discount %',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a discount';
                      }
                      final val = double.tryParse(value);
                      if (val == null || val <= 0 || val > 100) {
                        return 'Enter a valid discount (1–100)';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  child: ListTile(
                    title: const Text('Expiry Date'),
                    subtitle: Text(
                      expiryDateText,
                      style: TextStyle(
                        color: _expiryDate == null ? Colors.grey : Colors.black,
                      ),
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: _pickExpiryDate,
                  ),
                ),
                const SizedBox(height: 24),
                _isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _submitCoupon,
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Create Coupon',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 39, 132, 129),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Card-like decoration wrapper for input fields
  Widget _buildInputCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: child,
    );
  }
}
