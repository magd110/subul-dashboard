import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardFilterPanel extends StatefulWidget {
  final void Function({
    required String? fromDate,
    required String? toDate,
    required String? status,
    required int? customerId,
  }) onFilter;

  const DashboardFilterPanel({super.key, required this.onFilter});

  @override
  State<DashboardFilterPanel> createState() => _DashboardFilterPanelState();
}

class _DashboardFilterPanelState extends State<DashboardFilterPanel> {
  DateTime? fromDate;
  DateTime? toDate;
  String? status;
  int? customerId;

  final dateFormat = DateFormat('yyyy-MM-dd');

  // الحالات مع ترجمتها العربية للمستخدم
  final statusOptions = {
    'in_process': 'قيد المعالجة',
    'in_the_way': 'في الطريق',
    'delivered': 'تم التسليم',
    'rejected': 'مرفوض',
  };

  // مثال للعملاء، يمكن جلبهم من API
  final customerOptions = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // From Date
          ElevatedButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: fromDate ?? DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) setState(() => fromDate = picked);
            },
            child: Text(fromDate != null
                ? 'من: ${dateFormat.format(fromDate!)}'
                : 'اختر من تاريخ'),
          ),

          // To Date
          ElevatedButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: toDate ?? DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) setState(() => toDate = picked);
            },
            child: Text(toDate != null
                ? 'إلى: ${dateFormat.format(toDate!)}'
                : 'اختر إلى تاريخ'),
          ),

          // Status Dropdown
          DropdownButton<String>(
            hint: const Text('الحالة'),
            value: status,
            items: statusOptions.entries
                .map(
                    (e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                .toList(),
            onChanged: (val) => setState(() => status = val),
          ),

          // Filter Button
          ElevatedButton(
            onPressed: () {
              widget.onFilter(
                fromDate:
                    fromDate != null ? dateFormat.format(fromDate!) : null,
                toDate: toDate != null ? dateFormat.format(toDate!) : null,
                status: status,
                customerId: customerId,
              );
            },
            child: const Text('فلترة'),
          ),
        ],
      ),
    );
  }
}
