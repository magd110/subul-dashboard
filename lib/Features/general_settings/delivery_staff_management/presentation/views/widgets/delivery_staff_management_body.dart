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

            return LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 800; // إذا الشاشة كبيرة

                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.deepPurple.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: _buildTableView(
                            context, employees), // 👈 دائمًا جدول
                      ),
                    ),
                    SizedBox(height: AppSizes.heightRatio(context, 30)),

                    // 🔹 زر إضافة مع Animation Hover
                    Align(
                      alignment: Alignment.centerRight,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          transformAlignment: Alignment.center,
                          child: AddButton(
                            text: 'إضافة موظف',
                            icon: FontAwesomeIcons.plus,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => BlocProvider.value(
                                  value: context.read<DeliveryStaffCubit>(),
                                  child: const EmployeeDialog(
                                    text: "إضافة موظف جديد",
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
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
                    style: Styles.textStyle20.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("السكن",
                    style: Styles.textStyle20.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("رقم الهاتف",
                    style: Styles.textStyle20.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("المهنة",
                    style: Styles.textStyle20.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 60),
            ],
          ),
        ),

        // 🔹 القائمة
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width < 600
                ? 800 // حد أدنى لعرض الجدول في الموبايل
                : MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: Text(employee.name)),
                          Expanded(
                              flex: 2, child: Text(employee.address ?? '')),
                          Expanded(flex: 2, child: Text(employee.phone ?? '')),
                          Expanded(
                              flex: 2, child: Text(employee.jobTitle ?? '')),
                          Row(
                            children: [
                              IconButton(
                                icon: SvgPicture.asset(AssetsData.iconedit,
                                    width: 22, height: 22),
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
                                icon: SvgPicture.asset(AssetsData.icondelete,
                                    width: 22, height: 22),
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

  /// 📱 عرض كـ Cards للموبايل
  Widget _buildCardView(BuildContext context, List employees) {
    return ListView.builder(
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final employee = employees[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 3,
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.deepPurple, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("👤 الاسم: ${employee.name}",
                      style: Styles.textStyle17.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepPurple)),
                  Text("🏠 السكن: ${employee.address ?? '-'}",
                      style: Styles.textStyle17),
                  Text("📞 الهاتف: ${employee.phone ?? '-'}",
                      style: Styles.textStyle17),
                  Text("💼 المهنة: ${employee.jobTitle ?? '-'}",
                      style: Styles.textStyle17),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(AssetsData.iconedit,
                            width: 22, height: 22),
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
                        icon: SvgPicture.asset(AssetsData.icondelete,
                            width: 22, height: 22),
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
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
