import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/screens/funds/controller/funds_controller.dart';

/// Opens the Add / Withdraw bottom sheet.
void showAddWithdrawSheet(BuildContext context, FundsMainController controller, {required bool isAdd}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (_) => _AddWithdrawSheet(controller: controller, isAdd: isAdd),
  );
}

class _AddWithdrawSheet extends StatefulWidget {
  const _AddWithdrawSheet({required this.controller, required this.isAdd});
  final FundsMainController controller;
  final bool isAdd;

  @override
  State<_AddWithdrawSheet> createState() => _AddWithdrawSheetState();
}

class _AddWithdrawSheetState extends State<_AddWithdrawSheet> {
  final _amtCtrl = TextEditingController();
  String _error = '';

  static const _presets = [1000.0, 5000.0, 10000.0, 25000.0];

  @override
  void dispose() {
    _amtCtrl.dispose();
    super.dispose();
  }

  void _confirm() {
    final amt = double.tryParse(_amtCtrl.text.trim()) ?? 0;
    if (amt <= 0) {
      setState(() => _error = 'Enter a valid amount');
      return;
    }
    if (!widget.isAdd && amt > widget.controller.walletBalance.value) {
      setState(() => _error = 'Cannot withdraw more than ₹${widget.controller.walletBalance.value.toStringAsFixed(2)}');
      return;
    }
    if (widget.isAdd) {
      widget.controller.addFunds(amt);
    } else {
      widget.controller.withdrawFunds(amt);
    }
    Get.back();
    Get.snackbar(
      widget.isAdd ? 'Funds Added' : 'Funds Withdrawn',
      '₹${amt.toStringAsFixed(2)} ${widget.isAdd ? 'added to' : 'withdrawn from'} your wallet',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF36B37E),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = widget.isAdd ? const Color(0xFF36B37E) : const Color(0xFFFF5630);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(color: theme.dividerColor, borderRadius: BorderRadius.circular(2)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
            child: Row(children: [
              Text(
                widget.isAdd ? 'Add Funds' : 'Withdraw Funds',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
            ]),
          ),

          // Preset chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 8,
              children: _presets.map((amt) {
                return ActionChip(
                  label: Text('₹${amt.toInt()}'),
                  onPressed: () {
                    _amtCtrl.text = amt.toStringAsFixed(0);
                    setState(() => _error = '');
                  },
                  side: BorderSide(color: color.withOpacity(0.4)),
                  backgroundColor: color.withOpacity(0.08),
                  labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 12),

          // Amount field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _amtCtrl,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => setState(() => _error = ''),
              decoration: InputDecoration(
                labelText: 'Amount (₹)',
                prefixText: '₹ ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: color, width: 1.5)),
                errorText: _error.isEmpty ? null : _error,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Confirm button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _confirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                child: Text(
                  widget.isAdd ? 'Add Funds' : 'Withdraw',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
