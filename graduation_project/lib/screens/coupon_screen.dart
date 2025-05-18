// import 'package:flutter/material.dart';
// import 'package:graduation_project/modelNotUse/copoun_model_test.dart';
// import 'package:graduation_project/providerNotUse/copoun_provider_test.dart';
// import 'package:provider/provider.dart';
// class SellerCouponsPage extends StatelessWidget {
//   const SellerCouponsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Coupons')),
//       body: Consumer<CouponProvider>(               // rebuilds when list changes
//         builder: (_, provider, __) {
//           final coupons = provider.coupons;
//           if (coupons.isEmpty) {
//             return const Center(child: Text('No coupons yet.'));
//           }
//           return ListView.separated(
//             padding: const EdgeInsets.all(16),
//             itemCount: coupons.length,
//             separatorBuilder: (_, __) => const SizedBox(height: 8),
//             itemBuilder: (_, i) => _CouponTile(coupon: coupons[i]),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddCouponDialog(context), // pass root context
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   // ───────────────────────────────────────── ADD COUPON DIALOG
//   void _showAddCouponDialog(BuildContext rootCtx) {
//     final titleCtrl = TextEditingController();
//     final discountCtrl = TextEditingController();
//     DateTime? startDate;
//     DateTime? expiryDate;

//     showDialog(
//       context: rootCtx,
//       builder: (_) => StatefulBuilder(
//         builder: (dCtx, setState) => AlertDialog(
//           title: const Text('Add Coupon'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: titleCtrl,
//                   decoration: const InputDecoration(labelText: 'Title'),
//                 ),
//                 TextField(
//                   controller: discountCtrl,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(labelText: 'Discount %'),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(startDate == null
//                           ? 'No start date'
//                           : _fmtDate(startDate!)),
//                     ),
//                     TextButton(
//                       onPressed: () async {
//                         final picked = await showDatePicker(
//                           context: dCtx,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2100),
//                         );
//                         if (picked != null) setState(() => startDate = picked);
//                       },
//                       child: const Text('Pick Start'),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(expiryDate == null
//                           ? 'No expiry date'
//                           : _fmtDate(expiryDate!)),
//                     ),
//                     TextButton(
//                       onPressed: () async {
//                         final first = startDate ?? DateTime.now();
//                         final picked = await showDatePicker(
//                           context: dCtx,
//                           initialDate: first,
//                           firstDate: first,
//                           lastDate: DateTime(2100),
//                         );
//                         if (picked != null) setState(() => expiryDate = picked);
//                       },
//                       child: const Text('Pick Expiry'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(dCtx),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final title = titleCtrl.text.trim();
//                 final discount = double.tryParse(discountCtrl.text.trim());
//                 if (title.isEmpty ||
//                     discount == null ||
//                     startDate == null ||
//                     expiryDate == null) {
//                   ScaffoldMessenger.of(rootCtx).showSnackBar(
//                     const SnackBar(content: Text('Fill all fields')),
//                   );
//                   return;
//                 }
//                 // add via *root* context so we hit the same provider instance
//                 Provider.of<CouponProvider>(rootCtx, listen: false).addCoupon(
//                   Coupon(
//                     id: DateTime.now().millisecondsSinceEpoch.toString(),
//                     title: title,
//                     discount: discount,
//                     startDate: startDate!,
//                     expiryDate: expiryDate!,
//                   ),
//                 );
//                 Navigator.pop(dCtx); // close dialog
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   static String _fmtDate(DateTime d) =>
//       '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
// }

// // ────────────────────────────────────────── COUPON TILE
// class _CouponTile extends StatelessWidget {
//   const _CouponTile({required this.coupon});
//   final Coupon coupon;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Text(coupon.title),
//         subtitle: Text(
//           'Discount: ${coupon.discount}%\n'
//           'From: ${_fmtDate(coupon.startDate)} → ${_fmtDate(coupon.expiryDate)}',
//         ),
//       ),
//     );
//   }

//   static String _fmtDate(DateTime d) =>
//       '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providerNotUse/copoun_provider_test.dart'; // <- keep your imports
import '../modelNotUse/copoun_model_test.dart';

class SellerCouponsPage extends StatelessWidget {
  const SellerCouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Coupons',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),

      // ── Gradient top background ────────────────────────────────
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

          // ── Coupons list or empty state ───────────────────────
          Consumer<CouponProvider>(
            builder: (_, provider, __) {
              final coupons = provider.coupons;
              if (coupons.isEmpty) return const _EmptyState();
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 140, 16, 120),
                itemCount: coupons.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _CouponCard(coupon: coupons[i]),
              );
            },
          ),
        ],
      ),

      // ── Extended FAB ──────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddOrEditSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('New Coupon'),
        backgroundColor: const Color.fromARGB(255, 62, 196, 174),
        elevation: 4,
      ),
    );
  }

  // ────────────────────────────── ADD COUPON BOTTOM‑SHEET
//   void _showAddCouponSheet(BuildContext rootCtx) {
//     final formKey = GlobalKey<FormState>();
//     final titleCtrl = TextEditingController();
//     final discountCtrl = TextEditingController();
//     DateTime? startDate;
//     DateTime? expiryDate;

//     showModalBottomSheet(
//       context: rootCtx,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (ctx) => Padding(
//         padding: EdgeInsets.fromLTRB(
//           24,
//           24,
//           24,
//           MediaQuery.of(ctx).viewInsets.bottom + 24,
//         ),
//         child: Form(
//           key: formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade400,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text('Create Coupon',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//               const SizedBox(height: 24),

//               // ── Title field
//               TextFormField(
//                 controller: titleCtrl,
//                 decoration: const InputDecoration(
//                   labelText: 'Title',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) =>
//                     v!.trim().isEmpty ? 'Please enter a title' : null,
//               ),
//               const SizedBox(height: 16),

//               // ── Discount field
//               TextFormField(
//                 controller: discountCtrl,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: 'Discount %',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) {
//                   final d = double.tryParse(v ?? '');
//                   return (d == null || d <= 0)
//                       ? 'Enter a number greater than 0'
//                       : null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // ── Date pickers inline
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton.icon(
//                       icon: const Icon(Icons.today),
//                       label: Text(startDate == null
//                           ? 'Start date'
//                           : _fmtDate(startDate!)),
//                       onPressed: () async {
//                         final picked = await showDatePicker(
//                           context: ctx,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2100),
//                         );
//                         if (picked != null) {
//                           startDate = picked;
//                           (ctx as Element).markNeedsBuild();
//                         }
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: OutlinedButton.icon(
//                       icon: const Icon(Icons.event),
//                       label: Text(expiryDate == null
//                           ? 'Expiry date'
//                           : _fmtDate(expiryDate!)),
//                       onPressed: () async {
//                         final first = startDate ?? DateTime.now();
//                         final picked = await showDatePicker(
//                           context: ctx,
//                           initialDate: first,
//                           firstDate: first,
//                           lastDate: DateTime(2100),
//                         );
//                         if (picked != null) {
//                           expiryDate = picked;
//                           (ctx as Element).markNeedsBuild();
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 28),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child:
//                       const Text('Add Coupon', style: TextStyle(fontSize: 16)),
//                   onPressed: () {
//                     final valid = formKey.currentState!.validate() &&
//                         startDate != null &&
//                         expiryDate != null;
//                     if (!valid) return;

//                     Provider.of<CouponProvider>(rootCtx, listen: false)
//                         .addCoupon(
//                       Coupon(
//                         id: DateTime.now().millisecondsSinceEpoch.toString(),
//                         title: titleCtrl.text.trim(),
//                         discount: double.parse(discountCtrl.text.trim()),
//                         startDate: startDate!,
//                         expiryDate: expiryDate!,
//                       ),
//                     );
//                     Navigator.pop(ctx);
//                     ScaffoldMessenger.of(rootCtx).showSnackBar(
//                       const SnackBar(content: Text('Coupon created')),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   static String _fmtDate(DateTime d) =>
//       '${d.day.toString().padLeft(2, "0")}/${d.month.toString().padLeft(2, "0")}/${d.year}';
}

// ────────────────────────────────────────── COUPON CARD WIDGET
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
//               trailing: Chip(
//                 label: Text(active ? 'Active' : 'Expired'),
//                 backgroundColor: accent.withOpacity(.85),
//                 labelStyle: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

String _fmtDate(DateTime d) =>
    '${d.day.toString().padLeft(2, "0")}/${d.month.toString().padLeft(2, "0")}/${d.year}';
// }

void _showAddOrEditSheet(BuildContext rootCtx, {Coupon? edit}) {
  final isEdit = edit != null;
  final formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController(text: edit?.title ?? '');
  final discountCtrl =
      TextEditingController(text: isEdit ? edit!.discount.toString() : '');
  DateTime? startDate = edit?.startDate;
  DateTime? expiryDate = edit?.expiryDate;

  showModalBottomSheet(
    context: rootCtx,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.of(ctx).viewInsets.bottom + 24,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            Text(isEdit ? 'Edit Coupon' : 'Create Coupon',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 24),
            // title, discount fields (same as before) …
            // date pickers (same as before) …

            // ── Title field
            TextFormField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v!.trim().isEmpty ? 'Please enter a title' : null,
            ),
            const SizedBox(height: 16),

            // ── Discount field
            TextFormField(
              controller: discountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Discount %',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                final d = double.tryParse(v ?? '');
                return (d == null || d <= 0)
                    ? 'Enter a number greater than 0'
                    : null;
              },
            ),
            const SizedBox(height: 16),

            // ── Date pickers inline
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.today),
                    label: Text(startDate == null
                        ? 'Start date'
                        : _fmtDate(startDate!)),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        startDate = picked;
                        (ctx as Element).markNeedsBuild();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.event),
                    label: Text(expiryDate == null
                        ? 'Expiry date'
                        : _fmtDate(expiryDate!)),
                    onPressed: () async {
                      final first = startDate ?? DateTime.now();
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: first,
                        firstDate: first,
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        expiryDate = picked;
                        (ctx as Element).markNeedsBuild();
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(isEdit ? 'Save Changes' : 'Add Coupon',
                    style: const TextStyle(fontSize: 16)),
                onPressed: () {
                  final valid = formKey.currentState!.validate() &&
                      startDate != null &&
                      expiryDate != null;
                  if (!valid) return;

                  final coupon = Coupon(
                    id: isEdit
                        ? edit!.id
                        : DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleCtrl.text.trim(),
                    discount: double.parse(discountCtrl.text.trim()),
                    startDate: startDate!,
                    expiryDate: expiryDate!,
                  );

                  final prov =
                      Provider.of<CouponProvider>(rootCtx, listen: false);
                  isEdit ? prov.updateCoupon(coupon) : prov.addCoupon(coupon);

                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(rootCtx).showSnackBar(
                    SnackBar(
                        content:
                            Text(isEdit ? 'Coupon updated' : 'Coupon created')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _CouponCard extends StatelessWidget {
  const _CouponCard({required this.coupon});
  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final active =
        now.isAfter(coupon.startDate) && now.isBefore(coupon.expiryDate);
    final accent = active ? Colors.green : Colors.grey;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          Container(width: 6, color: accent),
          Expanded(
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              title: Text(coupon.title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Discount: ${coupon.discount.toStringAsFixed(0)} %\n'
                  'Valid: ${_fmtDate(coupon.startDate)} → ${_fmtDate(coupon.expiryDate)}',
                ),
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      _showAddOrEditSheet(context, edit: coupon);
                      break;
                    case 'delete':
                      Provider.of<CouponProvider>(context, listen: false)
                          .deleteCoupon(coupon.id);
                      break;
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'edit', child: Text('Edit')),
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────── EMPTY STATE
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 160),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_offer,
                size: 80, color: scheme.primary.withOpacity(.3)),
            const SizedBox(height: 12),
            const Text('No coupons yet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            const Text('Tap “New Coupon” to create one'),
          ],
        ),
      ),
    );
  }
}
