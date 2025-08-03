import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:subul_dashboard2/Features/dashboard/data/models/dashboard_statistics_model.dart';

class ShipmentStatusPie extends StatelessWidget {
  final List<ShipmentsByStatusPie> data;

  const ShipmentStatusPie({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data.fold<int>(0, (sum, item) => sum + item.count);

    final sections = data.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final percentage = item.count / total * 100;

      return PieChartSectionData(
        value: item.count.toDouble(),
        color: _getColor(index),
        title: '', // بدون عنوان داخل القطعة
        radius: 50,
      );
    }).toList();

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'حسب حالة الشحنة',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // الرسمة
                SizedBox(
                  height: 200,
                  width: 200,
                  child: PieChart(
                    PieChartData(
                      sections: sections,
                      centerSpaceRadius: 40,
                      sectionsSpace: 2,
                    ),
                  ),
                ),

                // التفاصيل
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: data.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        final percentage =
                            (item.count / total * 100).toStringAsFixed(1);

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
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
                              Expanded(
                                child: Text(
                                  item.status ?? 'غير معروف',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              Text(
                                '${item.count} (${percentage}%)',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Text(
                    total.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'إجمالي الشحنات',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
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
      Color(0xFF2E294E), // بنفسجي غامق
      Color(0xFF1B98E0), // أزرق
      Color(0xFFAAAAAA), // رمادي فاتح
      Color(0xFF9C27B0), // بنفسجي متوسط
      Color(0xFFFFB400), // أصفر برتقالي
      Colors.teal
    ];
    return colors[index % colors.length];
  }
}
