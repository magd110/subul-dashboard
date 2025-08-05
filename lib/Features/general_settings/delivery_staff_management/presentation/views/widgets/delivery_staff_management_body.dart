import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
                      border:
                          Border.all(color: AppColors.deepPurple, width: 3.0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: AppSizes.widthRatio(context, 880),
                    height: AppSizes.heightRatio(context, 620),
                    child: Column(
                      children: [
                      
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text("اسم الموظف",
                                      style: Styles.textStyle24.copyWith(
                                          fontSize: 24.sp,
                                          color: AppColors.black))),
                              Expanded(
                                  child: Text("السكن",
                                      style: Styles.textStyle24.copyWith(
                                          fontSize: 24.sp,
                                          color: AppColors.black))),
                              Expanded(
                                  child: Text("رقم الهاتف",
                                      style: Styles.textStyle24.copyWith(
                                          fontSize: 24.sp,
                                          color: AppColors.black))),
                              Expanded(
                                  child: Text("المهنة",
                                      style: Styles.textStyle24.copyWith(
                                          fontSize: 24.sp,
                                          color: AppColors.black))),
                            ],
                          ),
                        ),

                      
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: employees.length,
                            itemBuilder: (context, index) {
                              final employee = employees[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Container(
                                  height: AppSizes.heightRatio(context, 90),
                                  decoration: BoxDecoration(
                                    color: AppColors.extraLightGray,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(employee.name,
                                              style: Styles.textStyle17
                                                  .copyWith(
                                                      fontSize: 17.sp,
                                                      color: AppColors.black))),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(employee.address ?? '',
                                            style: Styles.textStyle17.copyWith(
                                                fontSize: 17.sp,
                                                color: AppColors.black)),
                                      )),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(employee.phone ?? '',
                                            style: Styles.textStyle17.copyWith(
                                                fontSize: 17.sp,
                                                color: AppColors.black)),
                                      )),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(employee.jobTitle ?? '',
                                            style: Styles.textStyle17.copyWith(
                                                fontSize: 17.sp,
                                                color: AppColors.black)),
                                      )),
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (dialogContext) =>
                                                        BlocProvider.value(
                                                          value: context.read<
                                                              DeliveryStaffCubit>(),
                                                          child:
                                                              EditEmployeeDialog(
                                                            text:
                                                                "تعديل بيانات موظف التسليم:",
                                                            id: employee.id!,
                                                            name: employee.name,
                                                            address: employee
                                                                    .address ??
                                                                "",
                                                            phone: employee
                                                                    .phone ??
                                                                "",
                                                            jobTitle: employee
                                                                .jobTitle,
                                                          ),
                                                        ));
                                              },
                                              child: SvgPicture.asset(
                                                AssetsData.iconedit,
                                                width: 24,
                                                height: 24,
                                              )),
                                          GestureDetector(
                                              onTap: () {
                                                print("1");
                                                showDialog(
                                                  context: context,
                                                  builder: (dialogContext) =>
                                                      BlocProvider.value(
                                                    value: context.read<
                                                        DeliveryStaffCubit>(),
                                                    child: DeleteEmployee(
                                                        id: employee.id!),
                                                  ),
                                                );
                                              },
                                              child: SvgPicture.asset(
                                                AssetsData.icondelete,
                                                width: 24,
                                                height: 24,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.heightRatio(context, 30)),
                Align(
                  alignment: Alignment.centerRight,
                  child: AddButton(
                    text: 'إضافة موظف',
                    icon: FontAwesomeIcons.plus,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => BlocProvider.value(
                          value: context.read<DeliveryStaffCubit>(),
                          child: const EmployeeDialog(
                            text: "إضافة موظف جديد",
                          ),
                        ),
                      );
                    },
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
}
