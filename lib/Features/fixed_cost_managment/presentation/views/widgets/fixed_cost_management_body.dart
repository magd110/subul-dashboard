import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/presentation/manager/fixed_cost_cubit.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/presentation/views/widgets/edit_fixed_cost_dialog.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';

class FixedCostManagementBody extends StatelessWidget {
  const FixedCostManagementBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.deepPurple,
        title: const Text(
          "إدارة التكاليف الثابتة",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FixedCostCubit, FixedCostState>(
        builder: (context, state) {
          if (state is FixedCostLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FixedCostFailure) {
            return Center(
              child: Text(
                "خطأ: ${state.errorMessage}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is FixedCostSuccess) {
            final fixedCosts = state.fixedCosts;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // عنوان القائمة
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "التكاليف الثابتة",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepPurple,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // قائمة التكاليف
                  Expanded(
                    child: ListView.builder(
                      itemCount: fixedCosts.length,
                      itemBuilder: (context, index) {
                        final cost = fixedCosts[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: InkWell(
                            onTap: () {}, // يمكن إضافة أي حدث لاحقًا
                            borderRadius: BorderRadius.circular(16),
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              shadowColor: Colors.grey.shade300,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.deepPurple.shade50
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                child: Row(
                                  children: [
                                    // اسم التكلفة
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        cost.name,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.deepPurple,
                                        ),
                                      ),
                                    ),

                                    // القيمة
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        cost.value,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),

                                    // أيقونة التعديل
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (dialogContext) =>
                                              BlocProvider.value(
                                            value:
                                                context.read<FixedCostCubit>(),
                                            child: EditFixedCostDialog(
                                              text: "تعديل السعر الثابت",
                                              id: cost.id,
                                              name: cost.name,
                                              value: cost.value,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: AppColors.deepPurple,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text("لا توجد بيانات بعد"));
        },
      ),
    );
  }
}
