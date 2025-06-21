import 'package:flutter/material.dart';
import 'package:graduation_project/providers/promo_code.dart';
import 'package:graduation_project/widgets/shipping_info_widget.dart';
import 'package:provider/provider.dart';
import '../providers/login_provider.dart';

class PromoCodeDialog extends StatefulWidget {
  @override
  _PromoCodeDialogState createState() => _PromoCodeDialogState();
}

class _PromoCodeDialogState extends State<PromoCodeDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  void _applyPromo() async {
    final promoCode = _controller.text.trim();
    if (promoCode.isEmpty) return;
    FocusScope.of(context).unfocus(); // 🧠 Hide keyboard

    setState(() => _isLoading = true);

    final token = Provider.of<LoginProvider>(context, listen: false).token;
    final result = await Provider.of<PromoCodeProvider>(context, listen: false)
        .applyPromo(promoCode, token);

    setState(() => _isLoading = false);
    Navigator.of(context).pop();
    if (Provider.of<PromoCodeProvider>(context, listen: false).result != null) {
      showDialog(
        context: context,
        builder: (context) => AddressDialog(),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Promo Code Error"),
            content: const Text("Invalid or expired promo code."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  void _noPromoCode() async {
    setState(() => _isLoading = true);

    final token = Provider.of<LoginProvider>(context, listen: false).token;
    final result = await Provider.of<PromoCodeProvider>(context, listen: false)
        .applyPromo("", token);

    setState(() => _isLoading = false);
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) => AddressDialog(),
    );
  }

  // showDialog(
  //   context: context,
  //   builder: (context) =>  AddressDialog(),
  // );
  // Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => AddressDialog())); // close dialog

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Promo Code'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: 'Promo Code',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          )
        else ...[
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: _noPromoCode,
                child: const Text('No Promo Code'),
              ),
              ElevatedButton(
                onPressed: _applyPromo,
                child: const Text('Apply',style: TextStyle(color: Color.fromRGBO(128, 23, 23, 0.894),),),
                
              ),
            ],
          )
        ]
      ],
    );
  }
}
