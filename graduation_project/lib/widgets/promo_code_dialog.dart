import 'package:flutter/material.dart';
import 'package:graduation_project/providers/promo_code.dart';
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
    Navigator.of(context).pop(); // close dialog
  }

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
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _applyPromo,
            child: const Text('Apply'),
          ),
        ]
      ],
    );
  }
}
