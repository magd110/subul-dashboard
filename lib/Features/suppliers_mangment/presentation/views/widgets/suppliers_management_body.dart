import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subul_dashboard2/Features/general_settings/widgets/add_button.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/presentation/manager/create_supplier_cubit.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/presentation/manager/create_supplier_state.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/presentation/manager/suppliers_cubit.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/presentation/manager/suppliers_state.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/presentation/views/widgets/supplier_dialog.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';
import 'package:subul_dashboard2/core/widgets/text_logo.dart';

class SuppliersManagementBody extends StatelessWidget {
  const SuppliersManagementBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                AppSizes.widthRatio(context, 30), 31, 0.0, 0.0),
            child: Align(alignment: Alignment.centerLeft, child: TextLogo()),
          ),
          SizedBox(height: AppSizes.heightRatio(context, 35)),
          Center(
            child: Text(
              "تفاصيل الموردين وشركات النقل",
              style: Styles.textStyle36.copyWith(
                  color: AppColors.deepPurple,
                  fontSize: 36.sp,
                  fontFamily: AssetsData.almarai),
            ),
          ),
          SizedBox(height: AppSizes.heightRatio(context, 35)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.widthRatio(context, 30)),
              child: BlocBuilder<SuppliersCubit, SuppliersState>(
                builder: (context, state) {
                  if (state is SuppliersLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SuppliersSuccess) {
                    final data = state.suppliers;

                    return Column(
                      children: [
                        // رؤوس الأعمدة
                        Container(
                          height: AppSizes.heightRatio(
                              context, 80), // ارتفاع أكبر للرأس
                          color: AppColors.deepPurple,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    'الاسم',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontFamily: AssetsData.almarai,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.goldenYellow,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    'الإيميل',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontFamily: AssetsData.almarai,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.goldenYellow,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    'الموقع',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontFamily: AssetsData.almarai,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.goldenYellow,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final supplier = data[index];
                              return Container(
                                height: AppSizes.heightRatio(
                                    context, 150), // ارتفاع أكبر لكل صف
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                          supplier.name,
                                          style: TextStyle(
                                            fontSize: 28.sp,
                                            fontFamily: AssetsData.poppins,
                                            color: AppColors.deepPurple,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Text(
                                          supplier.email,
                                          style: TextStyle(
                                            fontSize: 28.sp,
                                            fontFamily: AssetsData.poppins,
                                            color: AppColors.deepPurple,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Text(
                                          supplier.address,
                                          style: TextStyle(
                                            fontSize: 28.sp,
                                            fontFamily: AssetsData.poppins,
                                            color: AppColors.deepPurple,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is SuppliersFailure) {
                    return Center(
                        child: Text('حدث خطأ: ${state.errorMessage}'));
                  }
                  return Container();
                },
              ),
            ),
          ),
          SizedBox(height: AppSizes.heightRatio(context, 20)),
          Padding(
            padding: EdgeInsets.only(left: AppSizes.widthRatio(context, 30)),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                AddButton(
                  text: 'إضافة',
                  icon: FontAwesomeIcons.plus,
                  onPressed: () {
                    final cubit = context.read<CreateSupplierCubit>();

                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return BlocProvider.value(
                          value: cubit,
                          child: BlocListener<CreateSupplierCubit,
                              CreateSupplierState>(
                            listener: (listenerContext, state) {
                              if (state is CreateSupplierSuccess) {
                                // نستخدم listenerContext لإظهار Snackbar داخل الـ dialog
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("✅ تمت إضافة المورد بنجاح")),
                                );
                                context
                                    .read<SuppliersCubit>()
                                    .getSuppliers(); // تحديث قائمة الموردين
                                Navigator.pop(
                                    dialogContext); // إغلاق الـ dialog
                              } else if (state is CreateSupplierFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("❌ فشل: ${state.errorMessage}")),
                                );
                              }
                            },
                            child: SupplierDialog(
                              text: "إضافة مورد",
                              onSave: (name, location, email, phone) {
                                // ✅ نرسل البيانات للـ Cubit لإنشاء المورد
                                cubit.createSupplier(
                                  name: name,
                                  email: email,
                                  phone: phone,
                                  address: location,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
