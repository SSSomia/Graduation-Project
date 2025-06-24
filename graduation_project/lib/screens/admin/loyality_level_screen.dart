import 'package:flutter/material.dart';
import 'package:graduation_project/models/loyality_level_model_update.dart';
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
          backgroundColor: const Color.fromARGB(255, 255, 242, 242),
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
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
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
                                  backgroundColor:
                                      const Color.fromARGB(255, 174, 29, 29),
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
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => _showupdateLoyaltyLevelDialog(context),
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Update Level',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          backgroundColor:
                              const Color.fromARGB(255, 185, 30, 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ));
  }
}

void _showupdateLoyaltyLevelDialog(BuildContext context) {
  final _levelController = TextEditingController();
  final _requiredSpentController = TextEditingController();
  final _discountPercentageController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Add Loyalty Level"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _levelController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Level Number"),
            ),
            TextField(
              controller: _requiredSpentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Required Spent"),
            ),
            TextField(
              controller: _discountPercentageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Discount Percentage"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final levelNum = int.tryParse(_levelController.text);
              final Spent = double.tryParse(_requiredSpentController.text);
              final discount =
                  double.tryParse(_discountPercentageController.text);

              if (levelNum != null && Spent != null && discount != null) {
                LoyaltyLevelUpdate level = LoyaltyLevelUpdate(
                  id: 0,
                  level: levelNum,
                  requiredSpent: Spent,
                  discountPercentage: discount,
                );
                final token =
                    Provider.of<LoginProvider>(context, listen: false).token;
                final request = LoyaltyLevelUpdateRequest(levels: [level]);
                await Provider.of<LoyaltyLevelProvider>(context, listen: false)
                    .updateLoyaltyLevels(token, request);

                // LoyaltyLevelUpdate level = LoyaltyLevelUpdate(
                //     id: 0,
                //     level: levelNum,
                //     requiredSpent: Spent,
                //     discountPercentage: discount);
                // await Provider.of<LoyaltyLevelProvider>(context, listen: false)
                //     .updateLoyaltyLevels(token, level);
                // // TODO: Use Provider or your logic to handle the submitted data
                // // print(
                // //     "Level: $level, Required Spent: $requiredSpent, Discount: $discount%");
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Updated successfully")));
              } else {
                // Show error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please enter valid values")),
                );
              }
            },
            child: Text("Submit", style: TextStyle(color: const Color.fromARGB(255, 139, 18, 18)),),
          ),
        ],
      );
    },
  );
}
