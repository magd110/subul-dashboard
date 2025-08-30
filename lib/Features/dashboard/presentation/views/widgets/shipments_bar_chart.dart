import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:subul_dashboard2/Features/dashboard/data/models/dashboard_statistics_model.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';

class ShipmentsBarChart extends StatelessWidget {
  final List<ShipmentsByMonth> data;

  const ShipmentsBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'عدد الشحنات حسب الشهر',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              'الإجمالي: ${data.fold<int>(0, (sum, item) => sum + item.count)} شحنة',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.5,
              child: BarChart(
                BarChartData(
                  backgroundColor: Colors.white, 
                  alignment: BarChartAlignment.spaceAround,
                  maxY: _getMaxY(data),
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10,
                        getTitlesWidget: (value, _) => Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 10),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          final index = value.toInt();
                          return Text(
                            '${index + 1}', 
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(data.length, (index) {
                    final item = data[index];
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: item.count.toDouble(),
                          color: Colors.orange, 
                          borderRadius: BorderRadius.circular(4),
                          width: 14,
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: _getMaxY(data),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getMaxY(List<ShipmentsByMonth> data) {
    final maxCount =
        data.map((e) => e.count).fold<int>(0, (a, b) => a > b ? a : b);
    return (maxCount / 10.0).ceil() * 10.0 + 10;
  }
}
