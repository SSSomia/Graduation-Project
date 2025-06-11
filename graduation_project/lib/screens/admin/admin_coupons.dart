import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providerNotUse/copoun_provider_test.dart'; // <- keep your imports
import '../../modelNotUse/copoun_model_test.dart';

class AdminCoupons extends StatelessWidget {
  const AdminCoupons({super.key});

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
}

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
                        ? edit.id
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
