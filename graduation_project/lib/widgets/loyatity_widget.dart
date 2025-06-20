import 'package:flutter/material.dart';
import 'package:graduation_project/providers/loyality_provider.dart';
import 'package:provider/provider.dart';

class LoyaltyBanner extends StatefulWidget {
  final String token;

  const LoyaltyBanner({super.key, required this.token});

  @override
  State<LoyaltyBanner> createState() => _LoyaltyBannerState();
}

class _LoyaltyBannerState extends State<LoyaltyBanner> {
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      Provider.of<LoyaltyProvider>(context, listen: false)
          .loadLoyaltyStatus(widget.token);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoyaltyProvider>(
      builder: (context, provider, _) {
        final status = provider.loyaltyStatus;

        if (provider.isLoading) {
          return const SizedBox(
              height: 150, child: Center(child: CircularProgressIndicator()));
        }

        if (status == null) {
          return const SizedBox();
        }

        // return Card(
        //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        //   elevation: 4,
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        //   color: Colors.teal,
        //   child: Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         const Text("🎉 Loyalty Status",
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 18,
        //                 fontWeight: FontWeight.bold)),
        //         const SizedBox(height: 8),
        //         Text("Level: ${status.currentLevel}",
        //             style: const TextStyle(color: Colors.white70)),
        //         Text("Total Spent: \$${status.totalSpent}",
        //             style: const TextStyle(color: Colors.white70)),
        //         if (status.coupons.isNotEmpty) ...[
        //           const SizedBox(height: 10),
        //           const Text("Coupons:",
        //               style: TextStyle(
        //                   color: Colors.white, fontWeight: FontWeight.bold)),
        //           ...status.coupons
        //               .map((c) => Text("- $c",
        //                   style: const TextStyle(color: Colors.white70)))
        //               .toList(),
        //         ],
        //       ],
        //     ),
        //   ),
        // );
        return Center(
          child: SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.95, // 95% of screen width
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: Colors.teal,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "🎉 Loyalty Status",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text("Level: ${status.currentLevel}",
                        style: const TextStyle(color: Colors.white70)),
                    Text("Total Spent: ${status.totalSpent} EGP",
                        style: const TextStyle(color: Colors.white70)),
                    if (status.coupons.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      const Text("Coupons:",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      ...status.coupons.map((c) => Text("- $c",
                          style: const TextStyle(color: Colors.white70))),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
