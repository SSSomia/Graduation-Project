import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/loyality_level_provider.dart';
import 'package:provider/provider.dart';

class LoyaltyLevelsScreen extends StatefulWidget {
  const LoyaltyLevelsScreen({super.key});

  @override
  State<LoyaltyLevelsScreen> createState() => _LoyaltyLevelsScreenState();
}

class _LoyaltyLevelsScreenState extends State<LoyaltyLevelsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = Provider.of<LoginProvider>(context, listen: false).token;
      Provider.of<LoyaltyLevelProvider>(context, listen: false)
          .fetchLoyaltyLevels(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoyaltyLevelProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loyalty Levels'),
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
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: provider.levels.length,
                  itemBuilder: (context, index) {
                    final level = provider.levels[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundColor: const Color.fromARGB(255, 174, 29, 29),
                          child: Text(
                            '${level.discountPercentage}%',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        title: Text(
                          level.level,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          'Spend at least \$${level.requiredSpent}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
