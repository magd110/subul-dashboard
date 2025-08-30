import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/manager/delivery_staff_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/manager/delivery_staff_state.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/views/widgets/delete_employee.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/views/widgets/edit_employee_dialog.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/views/widgets/employee_dialog.dart';
import 'package:subul_dashboard2/Features/general_settings/widgets/add_button.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class DeliveryStaffManagementBody extends StatelessWidget {
  const DeliveryStaffManagementBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<DeliveryStaffCubit, DeliveryStaffState>(
        builder: (context, state) {
          if (state is DeliveryStaffLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DeliveryStaffFailure) {
            return Center(child: Text("خطأ: ${state.errorMessage}"));
          }

          if (state is DeliveryStaffSuccess) {
            final employees = state.staff;

            return Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.deepPurple, width: 3.0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: AppSizes.widthRatio(context, 880),
                    height: AppSizes.heightRatio(context, 620),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text("اسم الموظف",
                                    style: Styles.textStyle24.copyWith(fontSize: 24.sp, color: AppColors.black)),
                              ),
                              Expanded(
                                child: Text("السكن",
                                    style: Styles.textStyle24.copyWith(fontSize: 24.sp, color: AppColors.black)),
                              ),
                              Expanded(
                                child: Text("رقم الهاتف",
                                    style: Styles.textStyle24.copyWith(fontSize: 24.sp, color: AppColors.black)),
                              ),
                              Expanded(
                                child: Text("المهنة",
                                    style: Styles.textStyle24.copyWith(fontSize: 24.sp, color: AppColors.black)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: _buildTableView(context, employees),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.heightRatio(context, 30)),
              ],
            );
          }

          return const Center(child: Text("لا توجد بيانات بعد"));
        },
      ),
    );
  }

  Widget _buildTableView(BuildContext context, List employees) {
    return Column(
      children: [
        // 🔹 العناوين
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.deepPurple,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text("اسم الموظف",
                    style: Styles.textStyle20.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("السكن",
                    style: Styles.textStyle20.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("رقم الهاتف",
                    style: Styles.textStyle20.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("المهنة",
                    style: Styles.textStyle20.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 60),
            ],
          ),
        ),

        // 🔹 القائمة
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width < 600
                ? 800
                : MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: Text(employee.name)),
                          Expanded(flex: 2, child: Text(employee.address ?? '')),
                          Expanded(flex: 2, child: Text(employee.phone ?? '')),
                          Expanded(flex: 2, child: Text(employee.jobTitle ?? '')),
                          Row(
                            children: [
                              IconButton(
                                icon: SvgPicture.asset(AssetsData.iconedit, width: 22, height: 22),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => BlocProvider.value(
                                      value: context.read<DeliveryStaffCubit>(),
                                      child: EditEmployeeDialog(
                                        text: "تعديل بيانات موظف:",
                                        id: employee.id!,
                                        name: employee.name,
                                        address: employee.address ?? "",
                                        phone: employee.phone ?? "",
                                        jobTitle: employee.jobTitle,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: SvgPicture.asset(AssetsData.icondelete, width: 22, height: 22),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => BlocProvider.value(
                                      value: context.read<DeliveryStaffCubit>(),
                                      child: DeleteEmployee(id: employee.id!),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
