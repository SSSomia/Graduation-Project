// import 'package:flutter/material.dart';
// import 'package:graduation_project/models/dicount_seller_model.dart';
// import 'package:graduation_project/providers/discount_seller_provider.dart';
// import 'package:graduation_project/providers/login_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class CreateCouponPage extends StatefulWidget {
//   final int buyerId;
//   final String buyerName;

//   const CreateCouponPage({required this.buyerId, required this.buyerName});

//   @override
//   State<CreateCouponPage> createState() => _CreateCouponPageState();
// }

// class _CreateCouponPageState extends State<CreateCouponPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _discountController = TextEditingController();
//   final TextEditingController _codeController = TextEditingController();
//   DateTime? _expiryDate;
//   bool _isLoading = false;

//   Future<void> _pickExpiryDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now().add(Duration(days: 7)),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 365)),
//     );

//     if (picked != null) {
//       setState(() {
//         _expiryDate = picked;
//       });
//     }
//   }

//   void _submitCoupon() async {
//     if (_formKey.currentState!.validate() && _expiryDate != null) {
//       setState(() => _isLoading = true);

//       final code = _codeController.text.trim();
//       final discount = int.parse(_discountController.text.trim());
//       final expiry = _expiryDate!;

//       // TODO: Call your provider method with: widget.buyerId, code, discount, expiry
//       // Example:
//       // await Provider.of<DiscountProvider>(context, listen: false)
//       //     .createCoupon(widget.buyerId, code, discount, expiry);

//       final discounty = Discount(
//         userId: widget.buyerId,
//         couponCode: code,
//         discountPercentage: discount,
//         expiryDate: expiry,
//       );

//       final authProvider = Provider.of<LoginProvider>(context, listen: false);

//       final success =
//           await Provider.of<DiscountProvider>(context, listen: false)
//               .sendDiscount(discount: discounty, token: authProvider.token);

//       if (success) {
//         Navigator.pop(context); // dismiss sheet
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Discount sent!')),
//         );
//     //   } else {
//     //     final error =
//     //         Provider.of<DiscountProvider>(context, listen: false).errorMessage;
//     //     ScaffoldMessenger.of(context).showSnackBar(
//     //       SnackBar(content: Text(error ?? 'Error')),
//     //     );
//     //   }

//     //   setState(() => _isLoading = false);

//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(content: Text('Coupon created for ${widget.buyerName}')),
//     //   );

//     //   Navigator.pop(context);
//     // } else if (_expiryDate == null) {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     const SnackBar(content: Text('Please select an expiry date.')),
//     //   );
//     }}
//   }

//   @override
//   Widget build(BuildContext context) {
//     final expiryDateText = _expiryDate != null
//         ? DateFormat('yyyy-MM-dd').format(_expiryDate!)
//         : 'Select Expiry Date';

//     return Scaffold(
//       appBar: AppBar(title: Text('Create Coupon for ${widget.buyerName}')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _codeController,
//                 decoration: const InputDecoration(labelText: 'Coupon Code'),
//                 validator: (value) => (value == null || value.trim().isEmpty)
//                     ? 'Enter a coupon code'
//                     : null,
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: _discountController,
//                 decoration: const InputDecoration(labelText: 'Discount %'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) return 'Enter a discount';
//                   final val = double.tryParse(value);
//                   if (val == null || val <= 0 || val > 100)
//                     return 'Enter a valid discount (1–100)';
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 12),
//               ListTile(
//                 title: Text('Expiry Date'),
//                 subtitle: Text(expiryDateText),
//                 trailing: Icon(Icons.calendar_today),
//                 onTap: _pickExpiryDate,
//               ),
//               const SizedBox(height: 20),
//               _isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : ElevatedButton(
//                       onPressed: _submitCoupon,
//                       child: const Text('Create Coupon'),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




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
      appBar: AppBar(title: Text('Create Coupon for ${widget.buyerName}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Coupon Code'),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Enter a coupon code'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _discountController,
                decoration: const InputDecoration(labelText: 'Discount %'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter a discount';
                  final val = double.tryParse(value);
                  if (val == null || val <= 0 || val > 100)
                    return 'Enter a valid discount (1–100)';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                title: const Text('Expiry Date'),
                subtitle: Text(expiryDateText),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickExpiryDate,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitCoupon,
                      child: const Text('Create Coupon'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
