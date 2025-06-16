import 'package:flutter/material.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/seller_discount_provider.dart';
import 'package:graduation_project/screens/seller/my_buyers.dart';
import 'package:provider/provider.dart';

class SellerCouponsPage extends StatefulWidget {
  const SellerCouponsPage({super.key});

  @override
  State<SellerCouponsPage> createState() => _SellerCouponsPageState();
}

class _SellerCouponsPageState extends State<SellerCouponsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<LoginProvider>(context, listen: false);
      Provider.of<SellerDiscountProvider>(context, listen: false)
          .fetchDiscounts(authProvider.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Coupons',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Stack(
        children: [
          Container(
            height: 210,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 115, 201, 209),
                  Color.fromARGB(255, 30, 123, 131)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
            ),
          ),
          Center(
            child: Consumer<SellerDiscountProvider>(
                builder: (context, discountProvider, child) {
              if (discountProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final discounts = discountProvider.discounts;

              if (discounts.isEmpty) {
                return const Center(child: Text('No discounts available.'));
              }

              return ListView.builder(
                itemCount: discounts.length,
                itemBuilder: (context, index) {
                  final discount = discounts[index];

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text('Store: ${discount.store}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User: ${discount.user}'),
                          Text('Coupon Code: ${discount.couponCode}'),
                          Text('Discount: ${discount.discountPercentage}%'),
                          Text('Created: ${discount.createdAt.toLocal()}'),
                          Text('Expires: ${discount.expiryDate.toLocal()}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final confirm = await showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Delete Coupon'),
                              content: const Text(
                                  'Are you sure you want to delete this coupon?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(ctx, true);
                                    final authProvider =
                                        Provider.of<LoginProvider>(context,
                                            listen: false);
                                    await Provider.of<SellerDiscountProvider>(
                                            context,
                                            listen: false)
                                        .deleteDiscount(
                                            authProvider.token, discount.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Coupon deleted successfully')),
                                    );
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            final authProvider = Provider.of<LoginProvider>(
                                context,
                                listen: false);
                            await Provider.of<SellerDiscountProvider>(context,
                                    listen: false)
                                .deleteDiscount(
                                    authProvider.token, discount.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Coupon deleted successfully')),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => BuyersPage()));
        },
        icon: const Icon(Icons.add),
        label: const Text('New Coupon'),
        backgroundColor: const Color.fromARGB(255, 62, 196, 174),
        elevation: 4,
      ),
    );
  }
}

// String _fmtDate(DateTime d) =>
//     '${d.day.toString().padLeft(2, "0")}/${d.month.toString().padLeft(2, "0")}/${d.year}';
// }

// void _showAddOrEditSheet(BuildContext rootCtx, {Coupon? edit}) {
//   final isEdit = edit != null;
//   var userID = null;
//   final formKey = GlobalKey<FormState>();
//   final titleCtrl = TextEditingController(text: edit?.title ?? '');
//   final discountCtrl =
//       TextEditingController(text: isEdit ? edit!.discount.toString() : '');
//   DateTime? startDate = edit?.startDate;
//   DateTime? expiryDate = edit?.expiryDate;

//   showModalBottomSheet(
//     context: rootCtx,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//     ),
//     builder: (ctx) => Padding(
//       padding: EdgeInsets.fromLTRB(
//         24,
//         24,
//         24,
//         MediaQuery.of(ctx).viewInsets.bottom + 24,
//       ),
//       child: Form(
//         key: formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                     color: Colors.grey.shade400,
//                     borderRadius: BorderRadius.circular(2))),
//             const SizedBox(height: 20),
//             Text(isEdit ? 'Edit Coupon' : 'Create Coupon',
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//             const SizedBox(height: 24),
//             // title, discount fields (same as before) …
//             // date pickers (same as before) …

//             // ── Title field
//             TextFormField(
//               controller: titleCtrl,
//               decoration: const InputDecoration(
//                 labelText: 'Title',
//                 border: OutlineInputBorder(),
//               ),
//               validator: (v) =>
//                   v!.trim().isEmpty ? 'Please enter a title' : null,
//             ),
//             const SizedBox(height: 16),

//             // ── Discount field
//             TextFormField(
//               controller: discountCtrl,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: 'Discount %',
//                 border: OutlineInputBorder(),
//               ),
//               validator: (v) {
//                 final d = double.tryParse(v ?? '');
//                 return (d == null || d <= 0)
//                     ? 'Enter a number greater than 0'
//                     : null;
//               },
//             ),
//             const SizedBox(height: 16),

//             // ── Date pickers inline
//             Row(
//               children: [
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     icon: const Icon(Icons.event),
//                     label: Text(expiryDate == null
//                         ? 'Expiry date'
//                         : _fmtDate(expiryDate!)),
//                     onPressed: () async {
//                       final first = startDate ?? DateTime.now();
//                       final picked = await showDatePicker(
//                         context: ctx,
//                         initialDate: first,
//                         firstDate: first,
//                         lastDate: DateTime(2100),
//                       );
//                       if (picked != null) {
//                         expiryDate = picked;
//                         (ctx as Element).markNeedsBuild();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 child:
//                     Text('Choose Buyer', style: const TextStyle(fontSize: 16)),
//                 onPressed: () async {
//                   final result = await Navigator.push(
//                     rootCtx,
//                     MaterialPageRoute(builder: (_) => BuyersPage()),
//                   );

//                   if (result != null) {
//                     // print('Returned value: $result');

//                     userID = result;
//                     // You can use setState() here if needed
//                   }
//                 },
//               ),
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 child: Text(isEdit ? 'Save Changes' : 'Add Coupon',
//                     style: const TextStyle(fontSize: 16)),
//                 onPressed: () async {
//                   final valid =
//                       formKey.currentState!.validate() && expiryDate != null;
//                       print("object")
// ;                  //  userID != null;
//                   if (userID == null) {
//                     ScaffoldMessenger.of(rootCtx).showSnackBar(
//                       SnackBar(content: Text('Please choose a buyer')),
//                     );
//                     return; // Stop execution
//                   }
//                   //  if (!valid) return;
//                   final discount = Discount(
//                     userId: userID,
//                     couponCode: titleCtrl.text,
//                     discountPercentage: int.parse(discountCtrl.text),
//                     expiryDate: expiryDate!,
//                   );

//                   final authProvider =
//                       Provider.of<LoginProvider>(rootCtx, listen: false);

//                   final success = await Provider.of<DiscountProvider>(rootCtx,
//                           listen: false)
//                       .sendDiscount(
//                           discount: discount, token: authProvider.token);

//                   if (success) {
//                     ScaffoldMessenger.of(rootCtx).showSnackBar(
//                         SnackBar(content: Text('Discount sent!')));
//                   } else {
//                     final error =
//                         Provider.of<DiscountProvider>(rootCtx, listen: false)
//                             .errorMessage;
//                     ScaffoldMessenger.of(rootCtx).showSnackBar(
//                         SnackBar(content: Text(error ?? 'Error')));
//                   }

//                   // final coupon = Coupon(
//                   //   id: isEdit
//                   //       ? edit.id
//                   //       : DateTime.now().millisecondsSinceEpoch.toString(),
//                   //   title: titleCtrl.text.trim(),
//                   //   discount: double.parse(discountCtrl.text.trim()),
//                   //   startDate: startDate!,
//                   //   expiryDate: expiryDate!,
//                   // );

//                   // final prov =
//                   //     Provider.of<CouponProvider>(rootCtx, listen: false);
//                   // isEdit ? prov.updateCoupon(coupon) : prov.addCoupon(coupon);

//                   // Navigator.pop(ctx);
//                   // ScaffoldMessenger.of(rootCtx).showSnackBar(
//                   //   SnackBar(
//                   //       content:
//                   //           Text(isEdit ? 'Coupon updated' : 'Coupon created')),
//                   // );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// class _CouponCard extends StatelessWidget {
//   const _CouponCard({required this.coupon});
//   final Coupon coupon;

//   @override
//   Widget build(BuildContext context) {
//     final now = DateTime.now();
//     final active =
//         now.isAfter(coupon.startDate) && now.isBefore(coupon.expiryDate);
//     final accent = active ? Colors.green : Colors.grey;

//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       clipBehavior: Clip.hardEdge,
//       child: Row(
//         children: [
//           Container(width: 6, color: accent),
//           Expanded(
//             child: ListTile(
//               contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               title: Text(coupon.title,
//                   style: const TextStyle(fontWeight: FontWeight.w600)),
//               subtitle: Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: Text(
//                   'Discount: ${coupon.discount.toStringAsFixed(0)} %\n'
//                   'Valid: ${_fmtDate(coupon.startDate)} → ${_fmtDate(coupon.expiryDate)}',
//                 ),
//               ),
//               trailing: PopupMenuButton<String>(
//                 onSelected: (value) {
//                   switch (value) {
//                     case 'delete':
//                       Provider.of<CouponProvider>(context, listen: false)
//                           .deleteCoupon(coupon.id);
//                       break;
//                   }
//                 },
//                 itemBuilder: (_) => const [
//                   PopupMenuItem(value: 'edit', child: Text('Edit')),
//                   PopupMenuItem(value: 'delete', child: Text('Delete')),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ────────────────────────────────────────── EMPTY STATE
// class _EmptyState extends StatefulWidget {
//   const _EmptyState();

//   @override
//   State<_EmptyState> createState() => _EmptyStateState();
// }

// class _EmptyStateState extends State<_EmptyState> {
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final authProvider = Provider.of<LoginProvider>(context, listen: false);
//       Provider.of<SellerDiscountProvider>(context, listen: false)
//           .fetchDiscounts(
//         authProvider.token,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final scheme = Theme.of(context).colorScheme;
//     return Padding(
//         padding: const EdgeInsets.only(top: 160),
//         child: Center(
//           child: Consumer<SellerDiscountProvider>(
//               builder: (context, discountProvider, child) {
//             if (discountProvider.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             final discounts = discountProvider.discounts;

//             if (discounts.isEmpty) {
//               return const Center(child: Text('No discounts available.'));
//             }

//             return ListView.builder(
//               itemCount: discounts.length,
//               itemBuilder: (context, index) {
//                 final discount = discounts[index];

//                 return Card(
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: ListTile(
//                     title: Text('Store: ${discount.store}'),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('User: ${discount.user}'),
//                         Text('Coupon Code: ${discount.couponCode}'),
//                         Text('Discount: ${discount.discountPercentage}%'),
//                         Text('Created: ${discount.createdAt.toLocal()}'),
//                         Text('Expires: ${discount.expiryDate.toLocal()}'),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }),
//         )
//         // child: Column(
//         // mainAxisSize: MainAxisSize.min,
//         // children: [
//         //   Icon(Icons.local_offer,
//         //       size: 80, color: scheme.primary.withOpacity(.3)),
//         //   const SizedBox(height: 12),
//         //   const Text('No coupons yet',
//         //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
//         //   const SizedBox(height: 6),
//         //   const Text('Tap “New Coupon” to create one'),
//         // ],
//         // ),
//         // ),
//         );
//   }
// }
