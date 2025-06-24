
import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/admin_earnings_provider.dart';

class AdminPlatformEarningsScreen extends StatefulWidget {
  const AdminPlatformEarningsScreen({super.key});

  @override
  State<AdminPlatformEarningsScreen> createState() =>
      _AdminPlatformEarningsScreenState();
}

class _AdminPlatformEarningsScreenState
    extends State<AdminPlatformEarningsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<AdminEarningsProvider>(context, listen: false)
          .fetchReports(authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminEarningsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("📊 Platform Earnings Report"),
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 255, 251, 251),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
              ? Center(child: Text("Error: ${provider.error}"))
              : ListView.builder(
                  itemCount: provider.reports.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final report = provider.reports[index];
                    return Card(
                      elevation: 6,
                      margin: const EdgeInsets.only(bottom: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      shadowColor: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(report),
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 20,
                              runSpacing: 16,
                              children: [
                                _buildMetric(
                                  icon: Icons.shopping_cart,
                                  title: "Orders",
                                  value: report.orders.toString(),
                                ),
                                _buildMetric(
                                  icon: Icons.card_giftcard,
                                  title: "First Order Discount",
                                  value:
                                      "-\$${report.discounts.firstOrder.toStringAsFixed(2)}",
                                  valueColor: Colors.red,
                                ),
                                _buildMetric(
                                  icon: Icons.percent,
                                  title: "Total Discounts",
                                  value:
                                      "-\$${report.discounts.total.toStringAsFixed(2)}",
                                  valueColor: Colors.red,
                                ),
                                _buildMetric(
                                  icon: Icons.attach_money,
                                  title: "Gross Earnings",
                                  value:
                                      "+\$${report.platformEarnings.gross.toStringAsFixed(2)}",
                                  valueColor: Colors.green,
                                ),
                                _buildMetric(
                                  icon: Icons.money_off_csred_outlined,
                                  title: "Net After Discounts",
                                  value:
                                      "${report.platformEarnings.netAfterDiscounts >= 0 ? '+' : ''}\$${report.platformEarnings.netAfterDiscounts.toStringAsFixed(2)}",
                                  valueColor:
                                      report.platformEarnings.netAfterDiscounts >= 0
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _buildHeader(report) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            "(${report.period.startDate} → ${report.period.endDate})",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 224, 224),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            report.period.type.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 171, 24, 24),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetric({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black54)),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: valueColor ?? Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
