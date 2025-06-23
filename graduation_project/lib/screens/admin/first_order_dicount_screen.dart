
import 'package:flutter/material.dart';
import 'package:graduation_project/providers/first_order_dicount.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/providers/login_provider.dart';

class DiscountSettingsScreen extends StatefulWidget {
  const DiscountSettingsScreen({super.key});

  @override
  State<DiscountSettingsScreen> createState() =>
      _DiscountSettingsScreenState();
}

class _DiscountSettingsScreenState extends State<DiscountSettingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = Provider.of<LoginProvider>(context, listen: false).token;
      Provider.of<DiscountSettingsProvider>(context, listen: false)
          .fetchDiscountSettings(token);
    });
  }

  Future<void> _showUpdateDialog(BuildContext context) async {
    final token = Provider.of<LoginProvider>(context, listen: false).token;
    final provider =
        Provider.of<DiscountSettingsProvider>(context, listen: false);
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update First Order Discount'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(labelText: 'New Discount (%)'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final value = double.tryParse(controller.text);
                if (value != null) {
                  Navigator.pop(context);
                  final msg =
                      await provider.updateDiscountPercentage(token, value);
                  if (msg != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(msg),
                      backgroundColor: const Color.fromARGB(255, 181, 31, 31),
                    ));
                  }
                }
              },
              child: const Text('Update', style: TextStyle(color: Color.fromARGB(255, 179, 29, 29)),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DiscountSettingsProvider>(context);
    final settings = provider.settings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('First Order Discount'),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
              ? Center(
                  child: Text(
                    'Error: ${provider.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : settings == null
                  ? const Center(child: Text('No settings found.'))
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 238, 238),
                                  Color.fromARGB(255, 255, 130, 130)
                                ],
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Row(
                                children: [
                                  const Icon(Icons.discount_rounded,
                                      color: Color.fromARGB(255, 186, 37, 37), size: 32),
                                  const SizedBox(width: 16),
                                  Text(
                                    'Discount: ${settings.firstOrderDiscountPercentage}%',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () => _showUpdateDialog(context),
                            icon: const Icon(Icons.edit_outlined, color: Color.fromARGB(255, 255, 255, 255),),
                            label:
                                const Text('Update First Order Discount', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 185, 35, 35),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
    );
  }
}
