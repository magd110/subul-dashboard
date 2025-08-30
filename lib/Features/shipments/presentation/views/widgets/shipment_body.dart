import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/shipments/presentation/manager/shipment_cubit.dart';
import 'package:subul_dashboard2/Features/shipments/presentation/manager/shipment_state.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class ShipmentBody extends StatelessWidget {
  const ShipmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<ShipmentCubit, ShipmentState>(
        builder: (context, state) {
          if (state is ShipmentLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ShipmentFailure) {
            return Center(child: Text("خطأ: ${state.errorMessage}"));
          }

          if (state is ShipmentSuccess) {
            final shipments = state.shipments;

            return Column(
              children: [
                // 🔹 الجدول
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.deepPurple,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.deepPurple.withOpacity(0.1),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text(
                                    "اسم العميل",
                                    style: Styles.textStyle20
                                        .copyWith(fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Text(
                                    "رقم التتبع",
                                    style: Styles.textStyle20
                                        .copyWith(fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "الحالة",
                                    style: Styles.textStyle20
                                        .copyWith(fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "عدد الطرود",
                                    style: Styles.textStyle20
                                        .copyWith(fontWeight: FontWeight.bold),
                                  )),
                              // 🔹 زر الفلترة على نفس السطر
                              ElevatedButton.icon(
                                onPressed: () {
                                  _showFilterDialog(
                                      context, context.read<ShipmentCubit>());
                                },
                                icon: const Icon(
                                  Icons.filter_list,
                                  size: 16,
                                ),
                                label: const Text(
                                  "فلترة",
                                  style: TextStyle(fontSize: 14),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppColors.deepPurple.withOpacity(0.8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 🔹 بيانات الشحنات
                        Expanded(
                          child: ListView.builder(
                            itemCount: shipments.length,
                            itemBuilder: (context, index) {
                              final shipment = shipments[index];
                              String statusText =
                                  _translateStatus(shipment.status);

                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade300)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child:
                                            Text(shipment.customerName ?? "-")),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                            shipment.trackingNumber ?? "-")),
                                    Expanded(flex: 2, child: Text(statusText)),
                                    Expanded(
                                        flex: 1,
                                        child: Text(shipment
                                                .declaredParcelsCount
                                                ?.toString() ??
                                            "0")),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text("لا توجد بيانات بعد"));
        },
      ),
    );
  }

  String _translateStatus(String? status) {
    switch (status) {
      case "not_processed":
      case null:
        return "لم تبدأ المعالجة";
      case "in_process":
        return "قيد المعالجة";
      case "in_the_way":
        return "قيد التوصيل";
      case "delivered":
        return "تم التوصيل";
      case "rejected":
        return "ملغاة";
      default:
        return "غير معروفة";
    }
  }

  void _showFilterDialog(BuildContext context, ShipmentCubit cubit) {
    String? selectedStatus;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("اختر حالة الشحنة"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return DropdownButton<String>(
                isExpanded: true,
                value: selectedStatus,
                hint: const Text("اختر حالة"),
                items: [
                  "لم تبدأ المعالجة",
                  "قيد المعالجة",
                  "قيد التوصيل",
                  "تم التوصيل",
                  "ملغاة"
                ]
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
              );
            },
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("إلغاء")),
            ElevatedButton(
              onPressed: () {
                if (selectedStatus != null) {
                  String statusKey = _mapStatusToKey(selectedStatus!);
                  cubit.fetchShipments(statuses: [statusKey]);
                  Navigator.pop(context);
                }
              },
              child: const Text("تطبيق"),
            ),
          ],
        );
      },
    );
  }

  String _mapStatusToKey(String status) {
    switch (status) {
      case "لم تبدأ المعالجة":
        return "not_processed";
      case "قيد المعالجة":
        return "in_process";
      case "قيد التوصيل":
        return "in_the_way";
      case "تم التوصيل":
        return "delivered";
      case "ملغاة":
        return "rejected";
      default:
        return "";
    }
  }
}
