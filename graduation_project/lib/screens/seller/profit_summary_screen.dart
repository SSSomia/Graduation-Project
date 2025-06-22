import 'package:flutter/material.dart';
import 'package:graduation_project/models/seller_profit_data.dart';
import 'package:graduation_project/providers/seller_profit_data_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/login_provider.dart'; // Assuming this provides the token

class ProfitSummaryScreen extends StatefulWidget {
  const ProfitSummaryScreen({super.key});

  @override
  State<ProfitSummaryScreen> createState() => _ProfitSummaryScreenState();
}

class _ProfitSummaryScreenState extends State<ProfitSummaryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);

      // Load sellers on init
      Provider.of<ProfitSummaryProvider>(context, listen: false)
          .loadProfitSummary(authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfitSummaryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Profit Summary"), backgroundColor: const Color.fromARGB(255, 255, 241, 241),),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.profitSummary == null
              ? const Center(
                  child: Text("Load Profit Summary"),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildSection("Daily", provider.profitSummary!.daily),
                      _buildSection("Monthly", provider.profitSummary!.monthly),
                      _buildSection("Yearly", provider.profitSummary!.yearly),
                    ],
                  ),
                ),
    );
  }

  Widget _buildSection(String title, ProfitData data) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Before Discount: ${data.beforeDiscount}"),
            Text("After Discount: ${data.afterPersonalDiscount}"),
          ],
        ),
      ),
    );
  }
}
