import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/dashboard/presentation/manager/dashboard_cubit.dart';
import 'package:subul_dashboard2/Features/dashboard/presentation/manager/dashboard_state.dart';
import 'package:subul_dashboard2/Features/dashboard/presentation/views/widgets/download_report_button.dart';
import 'package:subul_dashboard2/Features/dashboard/presentation/views/widgets/driver_stat_card.dart';
import 'package:subul_dashboard2/Features/dashboard/presentation/views/widgets/shipment_status_pie.dart';
import 'package:subul_dashboard2/Features/dashboard/presentation/views/widgets/shipments_bar_chart.dart';
import 'package:subul_dashboard2/Features/dashboard/presentation/views/widgets/weight_bar_chart.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: AppColors.globalBackgroundGradient,
          child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DashboardFailure) {
                return Center(
                    child: Text('فشل في جلب البيانات: ${state.errorMessage}'));
              } else if (state is DashboardSuccess) {
                final data = state.data;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // العمود الأول - الرسوم البيانية
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            ShipmentsBarChart(data: data.shipmentsByMonth),
                            const SizedBox(height: 20),
                            WeightBarChart(data: data.shipmentsByWeightRange),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),

                      // العمود الثاني - البطاقات الإحصائية
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            DriverStatCard(
                              title: 'عدد السائقين',
                              value: data.driversCount.toString(),
                              color: Colors.amber,
                            ),
                            const SizedBox(height: 16),
                            DriverStatCard(
                              title: 'عدد الطرود اليوم',
                              value: data.shipmentsToday.toString(),
                              color: const Color(0xFF2E237C),
                            ),
                            const SizedBox(height: 16),
                            DriverStatCard(
                              title: 'عدد الطرود أسبوعياً',
                              value: data.shipmentsThisWeek.toString(),
                              color: const Color(0xFF00B3FF),
                            ),
                            const SizedBox(height: 16),
                            DriverStatCard(
                              title: 'الطرود المكتملة',
                              value: data.completedShipments.toString(),
                              color: const Color(0xFF8439D7),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),

                      // العمود الثالث - Pie Chart و الزر
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShipmentStatusPie(data: data.shipmentsByStatusPie),
                            const SizedBox(height: 16),
                            const DownloadReportButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Default case
              return const Center(child: Text("لا توجد بيانات"));
            },
          ),
        ),
      ),
    );
  }
}
