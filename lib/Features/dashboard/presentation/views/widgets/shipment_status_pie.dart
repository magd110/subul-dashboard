// shipment_status_pie.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subul_dashboard2/Features/dashboard/data/models/dashboard_statistics_model.dart';

class ShipmentStatusPie extends StatelessWidget {
  final List<ShipmentsByStatusPie> data;

  const ShipmentStatusPie({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data.fold<int>(0, (sum, item) => sum + item.count);

    // تصغير حجم الدائرة قليلاً
    final chartRadius =
        MediaQuery.of(context).size.width * 0.08; // 10% من عرض الشاشة
    final centerSpace = chartRadius * 0.25;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'حسب حالة الشحنة',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الرسم البياني
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SizedBox(
                    width: chartRadius * 2,
                    height: chartRadius * 2,
                    child: PieChart(
                      PieChartData(
                        sections: data.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return PieChartSectionData(
                            value: item.count.toDouble(),
                            color: _getColor(index),
                            title: '',
                            radius: chartRadius,
                          );
                        }).toList(),
                        centerSpaceRadius: centerSpace,
                        sectionsSpace: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                // الليجند
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.map((item) {
                      final index = data.indexOf(item);
                      final percentage = total > 0
                          ? (item.count / total * 100).toStringAsFixed(1)
                          : '0';
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.only(left: 8),
                              decoration: BoxDecoration(
                                color: _getColor(index),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              item.status ?? 'not_processed',
                              style: TextStyle(
                                  fontSize: 15.sp), // تكبير النص قليلاً
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '${item.count} (${percentage}%)',
                              style: TextStyle(
                                  fontSize: 15.sp), // تكبير النص قليلاً
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // إجمالي الشحنات
            Center(
              child: Column(
                children: [
                  Text(
                    total.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'إجمالي الشحنات',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(int index) {
    final colors = [
      const Color(0xFF2E294E),
      const Color(0xFF1B98E0),
      const Color(0xFFAAAAAA),
      const Color(0xFF9C27B0),
      const Color(0xFFFFB400),
      Colors.teal,
    ];
    return colors[index % colors.length];
  }
}
