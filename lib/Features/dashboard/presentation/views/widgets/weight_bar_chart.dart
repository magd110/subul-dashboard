import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:subul_dashboard2/Features/dashboard/data/models/dashboard_statistics_model.dart';

class WeightBarChart extends StatelessWidget {
  final List<ShipmentsByWeightRange> data;

  const WeightBarChart({super.key, required this.data});

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
              'عدد الشحنات حسب الوزن',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.7,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: _getMaxY(data),
                  backgroundColor: Colors.white,
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10,
                        getTitlesWidget: (value, _) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, _) {
                          final index = value.toInt();
                          if (index >= 0 && index < data.length) {
                            return Text(
                              data[index].range,
                              style: const TextStyle(fontSize: 12),
                              textDirection: TextDirection.rtl,
                            );
                          } else {
                            return const Text('');
                          }
                        },
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
                          color: _getColorForIndex(index),
                          width: 14,
                          borderRadius: BorderRadius.circular(4),
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

  double _getMaxY(List<ShipmentsByWeightRange> data) {
    final maxCount =
        data.map((e) => e.count).fold<int>(0, (a, b) => a > b ? a : b);
    return ((maxCount / 10).ceil() * 10).toDouble() + 10;
  }

  Color _getColorForIndex(int index) {
    final colors = [Colors.orange, Colors.blue, Colors.green];
    return colors[index % colors.length];
  }
}
